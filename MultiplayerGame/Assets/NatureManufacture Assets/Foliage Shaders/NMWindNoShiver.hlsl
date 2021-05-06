#define FLT_EPSILON 1.192092896e-07 

sampler2D WIND_SETTINGS_TexNoise;
sampler2D WIND_SETTINGS_TexGust;

//float _InitialBend;
//float _Stiffness;
//float _Drag;
//float4 _NewNormal;


float4  WIND_SETTINGS_WorldDirectionAndSpeed;
float   WIND_SETTINGS_FlexNoiseScale;
float   WIND_SETTINGS_Turbulence;
float   WIND_SETTINGS_GustSpeed;
float   WIND_SETTINGS_GustScale;
float   WIND_SETTINGS_GustWorldScale;

//float PositivePow(float base, float power)
//{
//    return pow(max(abs(base), float(FLT_EPSILON)), power);
//}

float AttenuateTrunk(float x, float s)
{
    float r = (x / s);
    return PositivePow(r,1/s);
}


float3 Rotate(float3 pivot, float3 position, float3 rotationAxis, float angle)
{
    rotationAxis = normalize(rotationAxis);
    float3 cpa = pivot + rotationAxis * dot(rotationAxis, position - pivot);
    return cpa + ((position - cpa) * cos(angle) + cross(rotationAxis, (position - cpa)) * sin(angle));
}

struct WindData
{
    float3 Direction;
    float Strength;
	float Gust;
};


float3 texNoise(float3 worldPos, float LOD)
{
	return tex2Dlod(WIND_SETTINGS_TexNoise,float4(worldPos.xz,0,LOD)).xyz -0.5;
}

float texGust(float3 worldPos, float LOD)
{
    return tex2Dlod(WIND_SETTINGS_TexGust, float4(worldPos.xz,0, LOD)).x;
}


WindData GetAnalyticalWind(float3 WorldPosition, float3 PivotPosition, float drag, float initialBend, float time)
{
    WindData result;
    float3 normalizedDir = normalize(WIND_SETTINGS_WorldDirectionAndSpeed.xyz);

    float3 worldOffset = normalizedDir * WIND_SETTINGS_WorldDirectionAndSpeed.w * time;
    float3 gustWorldOffset = normalizedDir * WIND_SETTINGS_GustSpeed * time;

    // Trunk noise is base wind + gusts + noise

    float3 trunk = float3(0,0,0);

    if(WIND_SETTINGS_WorldDirectionAndSpeed.w > 0.0 || WIND_SETTINGS_Turbulence > 0.0)
    {
        trunk = texNoise((PivotPosition - worldOffset)*WIND_SETTINGS_FlexNoiseScale,3);
    }

    float gust  = 0.0;

    if(WIND_SETTINGS_GustSpeed > 0.0)
    {
        gust = texGust((PivotPosition - gustWorldOffset)*WIND_SETTINGS_GustWorldScale,3);
        gust = pow(gust, 2) * WIND_SETTINGS_GustScale;
    }

    float3 trunkNoise =
        (
                (normalizedDir * WIND_SETTINGS_WorldDirectionAndSpeed.w)
                + (gust * normalizedDir * WIND_SETTINGS_GustSpeed)
                + (trunk * WIND_SETTINGS_Turbulence)
        ) * drag;


    float3 dir = trunkNoise;
    float flex = length(trunkNoise) + initialBend;

    result.Direction = dir;
    result.Strength = flex;
	result.Gust =  ((gust * normalizedDir * WIND_SETTINGS_GustSpeed)
		+ (trunk * WIND_SETTINGS_Turbulence)).x;

    return result;
}



void ApplyWindDisplacement( inout float3    positionWS,
							inout WindData    windData,
                            float3          normalWS,
                            float3          rootWP,
                            float           stiffness,
                            float           drag,
                            float           initialBend,
                            float          time)
{
    WindData wind = GetAnalyticalWind(positionWS, rootWP, drag, initialBend, time);

    if (wind.Strength > 0.0)
    {
        float att = AttenuateTrunk(distance(positionWS, rootWP), stiffness);
        float3 rotAxis = cross(float3(0, 1, 0), wind.Direction);

        positionWS = Rotate(rootWP, positionWS, rotAxis, (wind.Strength) * 0.001 * att);

    }
	windData = wind;

}





void CalculateWind(float3 vertexIn, float3 normalIn, float timeIn, out float3 vertex, out float3 normal) {

	vertex = vertexIn;
	normal = normalIn;

	float3 positionWS = TransformObjectToWorld(vertex.xyz);

    float3 rootWP = mul(GetObjectToWorldMatrix(), float4(0, 0, 0, 1)).xyz;


	float3 normalWS =  TransformObjectToWorldNormal(normal);

	WindData windData;

	ApplyWindDisplacement(positionWS, windData, normalWS, rootWP, _Stiffness, _Drag, _InitialBend, timeIn);


    vertex.xyz = TransformWorldToObject(positionWS).xyz;


	if (_NewNormal.x != 0 && _NewNormal.y != 0 && _NewNormal.z != 0)
		normal *= _NewNormal.xyz;

 }

void CalculateWind_float(float3 vertexIn, float3 normalIn, float timeIn, out float3 vertex, out float3 normal) {
	CalculateWind(vertexIn, normalIn, timeIn, vertex, normal);
}




