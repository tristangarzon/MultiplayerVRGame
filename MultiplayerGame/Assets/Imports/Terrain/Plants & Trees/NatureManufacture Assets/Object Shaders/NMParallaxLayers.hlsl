

float3 GetDisplacementObjectScaleLayers()
{
                
    float3 objectScale = float3(1.0, 1.0, 1.0);
    float4x4 worldTransform = GetWorldToObjectMatrix();
                
    objectScale.x = length(float3(worldTransform._m00, worldTransform._m01, worldTransform._m02));
    objectScale.z = length(float3(worldTransform._m20, worldTransform._m21, worldTransform._m22));
                
    return objectScale;
}


float4 BlendLightenLayers(float4 Base, float4 Blend, float Opacity)
{
   
    float4 Out = max(Blend, Base);
    Out = lerp(Base, Out, Opacity);

    return Out;
}


void ParallaxLayers(float Steps, float2 uv, float StartOffset, float OffsetScale, float3 viewTangent, float3 viewWorld, float blend, bool isPlanar, out float4 Out)
{
    
     
    //float3 viewTG = isPlanar ? float3(float2(viewTangent.x, viewTangent.z), abs(viewTangent.y)) : viewTangent;
    float3 viewTG = isPlanar ? float3(float2(viewWorld.x, viewWorld.z), abs(viewWorld.y)) : viewTangent;
               
    viewTG = normalize(float3(viewTG.xy, viewTG.z)); // * amplitude * 0.01


    float4 parallax = 0;
    for (int j = 0; j < Steps; j++)
    {
        if (j == 0)               
            parallax = float4(0, 0, 0, 0);
        else
        {
        

            float ratio = (float) j / Steps;
        //float4 newParalax = (SAMPLE_TEXTURE2D(_ParalaxMap, sampler_ParalaxMap, uv + lerp(0, OffsetScale * 0.01, ratio) * viewTangent.xy) * lerp(1, 0, ratio));

            float4 newParalax = SAMPLE_TEXTURE2D(_ParalaxMap, sampler_ParalaxMap, uv + j * OffsetScale * 0.01 * viewTG.xy + viewTG.xy * 0.01 * StartOffset);
       
            newParalax = lerp(newParalax, float4(0, 0, 0, 0), ratio);
       
     
            parallax = BlendLightenLayers(parallax, newParalax, blend);
        }
        
       
    }

    Out = parallax;
}


void ParallaxLayers_float(float Steps, float2 uv, float StartOffset, float OffsetScale, float3 viewTangent, float3 viewWorld, float blend, bool isPlanar, out
float4 Out)
{
    ParallaxLayers(Steps, uv, StartOffset, OffsetScale, viewTangent, viewWorld, blend, isPlanar, Out);
}