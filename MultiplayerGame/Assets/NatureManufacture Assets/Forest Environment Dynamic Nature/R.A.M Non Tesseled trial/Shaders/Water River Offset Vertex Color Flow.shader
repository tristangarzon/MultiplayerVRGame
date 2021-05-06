Shader "NatureManufacture Shaders/Water/Water River Offset Vertex Color Flow"
{
    Properties
    {
        _GlobalTiling("Global Tiling", Range(0.001, 100)) = 1
        [ToggleUI]_UVVDirection1UDirection0("UV Direction - V(T) U(F)", Float) = 1
        _SlowWaterSpeed("Main Water Speed", Vector) = (0.3, 0.3, 0, 0)
        _SlowWaterMixSpeed("Wind Water Mix Speed", Vector) = (0.003, 0.003, 0, 0)
        _SmallCascadeMainSpeed("Small Cascade Main Speed", Vector) = (1, 1, 0, 0)
        _BigCascadeMainSpeed("Big Cascade Main Speed", Vector) = (0.9, 0.9, 0, 0)
        _EdgeFalloffMultiply("Edge Falloff Multiply", Float) = 5.19
        _EdgeFalloffPower("Edge Falloff Power", Float) = 0.74
        _CleanFalloffMultiply("Clean Falloff Multiply", Float) = 2.41
        _CleanFalloffPower("Clean Falloff Power", Float) = 0.41
        _ShalowColor("Shalow Color", Color) = (0.1781772, 0.227305, 0.2641509, 0)
        _ShalowFalloffMultiply("Shalow Falloff Multiply", Float) = 1.043
        _ShalowFalloffPower("Shalow Falloff Power", Float) = 3.9
        _DeepColor("Deep Color", Color) = (0.02625489, 0.03987184, 0.09433956, 0)
        _WaterAlphaMultiply("Water Alpha Multiply", Float) = 0.66
        _WaterAlphaPower("Water Alpha Power", Float) = 1.39
        _WaveTranslucencyFallOffDistance("Wave Translucency FallOff Distance", Float) = 30
        _WaveTranslucencyPower("Wave Translucency Power", Range(0, 10)) = 1.64
        _WaveTranslucencyHardness("Wave Translucency Hardness", Range(0, 10)) = 0.7
        _WaveTranslucencyMultiply("Wave Translucency Multiply", Range(0, 10)) = 0.16
        _SlowWaterTranslucencyMultiply("Slow Water Translucency Multiply", Range(0, 10)) = 1
        _SmallCascadeTranslucencyMultiply("Small Cascade Translucency Multiply", Range(0, 10)) = 1
        _BigCascadeTranslucencyMultiply("Big Cascade Translucency Multiply", Range(0, 10)) = 0.69
        _WaterSmoothness("Water Smoothness", Range(0, 1)) = 0.9
        _WaterSpecularClose("Water Specular Close", Range(0, 1)) = 0.9
        _WaterSpecularFar("Water Specular Far", Range(0, 1)) = 0.9
        _WaterSpecularThreshold("Water Specular Threshold", Range(0, 10)) = 0.39
        _Distortion("Distortion", Range(0, 1)) = 0.1
        _BackfaceAlpha("Backface Alpha", Range(0, 1)) = 0.85
        _MicroWaveNormalScale("Wind Micro Wave Normal Scale", Range(0, 2)) = 0.15
        _MicroWaveTiling("Wind Micro Wave Tiling", Vector) = (1.1, 1.1, 0, 0)
        _MacroWaveNormalScale("Wind Macro Wave Normal Scale", Range(0, 2)) = 0.15
        _MacroWaveTiling("Wind Macro Wave Tiling", Vector) = (10, 10, 0, 0)
        [NoScaleOffset]_SlowWaterNormal("Water Normal", 2D) = "bump" {}
        _SlowWaterTiling("Water Tiling", Vector) = (1, 1, 0, 0)
        _SlowNormalScale("Water Normal Scale", Float) = 0.3
        _FarNormalPower("Far Normal Power", Range(0, 1)) = 0.5
        _FarNormalBlendStartDistance("Far Normal Blend Start Distance", Float) = 20
        _FarNormalBlendThreshold("Far Normal Blend Threshold", Range(0, 10)) = 10
        _SmallCascadeAngle("Small Cascade Angle", Range(0.001, 90)) = 0.6
        _SmallCascadeAngleFalloff("Small Cascade Angle Falloff", Range(0, 80)) = 2
        [NoScaleOffset]_SmallCascadeNormal("Small Cascade Normal", 2D) = "bump" {}
        _SmallCascadeTiling("Small Cascade Tiling", Vector) = (2, 2, 0, 0)
        _SmallCascadeNormalScale("Small Cascade Normal Scale", Float) = 0.5
        [NoScaleOffset]_SmallCascade("Small Cascade", 2D) = "white" {}
        _SmallCascadeColor("Small Cascade Color", Vector) = (20, 20, 20, 0)
        _SmallCascadeFoamFalloff("Small Cascade Foam Falloff", Range(0, 10)) = 4.11
        _SmallCascadeSmoothness("Small Cascade Smoothness", Range(0, 1)) = 0
        _SmallCascadeSpecular("Small Cascade Specular", Range(0, 1)) = 0.8
        _BigCascadeAngle("Big Cascade Angle", Range(0.001, 90)) = 10.2
        _BigCascadeAngleFalloff("Big Cascade Angle Falloff", Range(0, 80)) = 2.3
        [NoScaleOffset]_BigCascadeNormal("Big Cascade Normal", 2D) = "bump" {}
        _BigCascadeNormalScale("Big Cascade Normal Scale", Float) = 0.6
        _BigCascadeTiling("Big Cascade Tiling", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_BigCascade("Big Cascade", 2D) = "white" {}
        _BigCascadeColor("Big Cascade Color", Vector) = (20, 20, 20, 0)
        Big_Cascade_Foam_Falloff("Big Cascade Foam Falloff", Range(0, 10)) = 2.86
        _BigCascadeTransparency("Big Cascade Transparency", Range(0, 1)) = 0.005
        _BigCascadeSmoothness("Big Cascade Smoothness", Range(0, 1)) = 0
        _BigCascadeSpecular("Big Cascade Specular", Range(0, 1)) = 0.84
        [NoScaleOffset]_SlowWaterTesselation("Water Tess", 2D) = "black" {}
        _SlowWaterTessScale("Water Tess Scale", Float) = 0.05
        MacroWaveTessScale("Wind Macro Wave Tess Scale", Float) = 0.05
        [NoScaleOffset]_SmallCascadeWaterTess("Small Cascade Water Tess", 2D) = "black" {}
        _SmallCascadeWaterTessScale("Small Cascade Water Tess Scale", Float) = 0.1
        [NoScaleOffset]BigCascadeWaterTess("Big Cascade Water Tess", 2D) = "black" {}
        _BigCascadeWaterTessScale("Big Cascade Water Tess Scale", Float) = 0.3
        _SmallCascadeNoisePower("Small Cascade Noise Power", Range(0, 10)) = 8.4
        _BigCascadeNoisePower("Big Cascade Noise Power", Range(0, 10)) = 10
        _SmallCascadeNoiseMultiply("Small Cascade Noise Multiply", Range(0, 40)) = 28.7
        _BigCascadeNoiseMultiply("Big Cascade Noise Multiply", Range(0, 40)) = 20
        [NoScaleOffset]_Foam("Foam", 2D) = "white" {}
        _FoamTiling("Foam Tiling", Vector) = (3, 3, 0, 0)
        _FoamSpeed("Foam Speed", Vector) = (0.3, 0.3, 0, 0)
        _FoamColor("Foam Color", Vector) = (4, 4, 4, 0)
        _FoamDepth("Foam Depth", Range(0, 10)) = 0.99
        _FoamFalloff("Foam Falloff", Range(-100, 0)) = -15.3
        _FoamWaveHardness("Foam Wave Hardness", Range(0, 10)) = 2.91
        _FoamWavePower("Foam Wave Power", Range(0, 10)) = 4.39
        _FoamWaveMultiply("Foam Wave Multiply", Range(0, 10)) = 6.17
        _FoamSmoothness("Foam Smoothness", Range(0, 1)) = 0
        _FoamSpecular("Foam Specular", Range(0, 1)) = 0
        [NoScaleOffset]_Noise("Noise", 2D) = "white" {}
        _NoiseTiling("Noise Tiling", Vector) = (2, 2, 0, 0)
        _NoiseSpeed("Noise Speed", Vector) = (3, 3, 0, 0)
        _AOPower("AO Power", Range(0, 1)) = 1
        _WaterFlowUVRefresSpeed("Water Flow UV Refresh Speed", Range(0, 1)) = 0.15
        _SmallCascadeFlowUVRefreshSpeed("Small Cascade Flow UV Refresh Speed", Range(0, 1)) = 0.2
        _BigCascadeFlowUVRefreshSpeed("Big Cascade Flow UV Refresh Speed", Range(0, 1)) = 0.4
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "Queue"="Transparent+0"
        }
        
        Pass
        {
            Name "Universal Forward"
            Tags 
            { 
                "LightMode" = "UniversalForward"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_fog
            #pragma multi_compile_instancing
        
            // Keywords
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
            #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
            // GraphKeywords: <None>
            
            // Defines
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define _NORMALMAP 1
            #define _SPECULAR_SETUP
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS 
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define VARYINGS_NEED_CULLFACE
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_FORWARD
            #define REQUIRE_DEPTH_TEXTURE
            #define REQUIRE_OPAQUE_TEXTURE
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float _GlobalTiling;
            float _UVVDirection1UDirection0;
            float2 _SlowWaterSpeed;
            float2 _SlowWaterMixSpeed;
            float2 _SmallCascadeMainSpeed;
            float2 _BigCascadeMainSpeed;
            float _EdgeFalloffMultiply;
            float _EdgeFalloffPower;
            float _CleanFalloffMultiply;
            float _CleanFalloffPower;
            float4 _ShalowColor;
            float _ShalowFalloffMultiply;
            float _ShalowFalloffPower;
            float4 _DeepColor;
            float _WaterAlphaMultiply;
            float _WaterAlphaPower;
            float _WaveTranslucencyFallOffDistance;
            float _WaveTranslucencyPower;
            float _WaveTranslucencyHardness;
            float _WaveTranslucencyMultiply;
            float _SlowWaterTranslucencyMultiply;
            float _SmallCascadeTranslucencyMultiply;
            float _BigCascadeTranslucencyMultiply;
            float _WaterSmoothness;
            float _WaterSpecularClose;
            float _WaterSpecularFar;
            float _WaterSpecularThreshold;
            float _Distortion;
            float _BackfaceAlpha;
            float _MicroWaveNormalScale;
            float2 _MicroWaveTiling;
            float _MacroWaveNormalScale;
            float2 _MacroWaveTiling;
            float2 _SlowWaterTiling;
            float _SlowNormalScale;
            float _FarNormalPower;
            float _FarNormalBlendStartDistance;
            float _FarNormalBlendThreshold;
            float _SmallCascadeAngle;
            float _SmallCascadeAngleFalloff;
            float2 _SmallCascadeTiling;
            float _SmallCascadeNormalScale;
            float3 _SmallCascadeColor;
            float _SmallCascadeFoamFalloff;
            float _SmallCascadeSmoothness;
            float _SmallCascadeSpecular;
            float _BigCascadeAngle;
            float _BigCascadeAngleFalloff;
            float _BigCascadeNormalScale;
            float2 _BigCascadeTiling;
            float3 _BigCascadeColor;
            float Big_Cascade_Foam_Falloff;
            float _BigCascadeTransparency;
            float _BigCascadeSmoothness;
            float _BigCascadeSpecular;
            float _SlowWaterTessScale;
            float MacroWaveTessScale;
            float _SmallCascadeWaterTessScale;
            float _BigCascadeWaterTessScale;
            float _SmallCascadeNoisePower;
            float _BigCascadeNoisePower;
            float _SmallCascadeNoiseMultiply;
            float _BigCascadeNoiseMultiply;
            float2 _FoamTiling;
            float2 _FoamSpeed;
            float3 _FoamColor;
            float _FoamDepth;
            float _FoamFalloff;
            float _FoamWaveHardness;
            float _FoamWavePower;
            float _FoamWaveMultiply;
            float _FoamSmoothness;
            float _FoamSpecular;
            float2 _NoiseTiling;
            float2 _NoiseSpeed;
            float _AOPower;
            float _WaterFlowUVRefresSpeed;
            float _SmallCascadeFlowUVRefreshSpeed;
            float _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); float4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_SmallCascadeNormal); SAMPLER(sampler_SmallCascadeNormal); float4 _SmallCascadeNormal_TexelSize;
            TEXTURE2D(_SmallCascade); SAMPLER(sampler_SmallCascade); float4 _SmallCascade_TexelSize;
            TEXTURE2D(_BigCascadeNormal); SAMPLER(sampler_BigCascadeNormal); float4 _BigCascadeNormal_TexelSize;
            TEXTURE2D(_BigCascade); SAMPLER(sampler_BigCascade); float4 _BigCascade_TexelSize;
            TEXTURE2D(_SlowWaterTesselation); SAMPLER(sampler_SlowWaterTesselation); float4 _SlowWaterTesselation_TexelSize;
            TEXTURE2D(_SmallCascadeWaterTess); SAMPLER(sampler_SmallCascadeWaterTess); float4 _SmallCascadeWaterTess_TexelSize;
            TEXTURE2D(BigCascadeWaterTess); SAMPLER(samplerBigCascadeWaterTess); float4 BigCascadeWaterTess_TexelSize;
            TEXTURE2D(_Foam); SAMPLER(sampler_Foam); float4 _Foam_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); float4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2DLOD_35997DE_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F6D4A02B_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_CABCD0D0_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_2BB41D12_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F0E303B2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_27B55B65_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_4648E9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_F765A3FA_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_49A71497_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6ABE710E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6FC3A421_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_13F501DC_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_C713F57F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_5CD91024_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_28CB720F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_8FF1FC6F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_3D04E744_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_FDC3D2E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D6FF940D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_80481243_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D803AB07_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_198CC76A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_387AEB22_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9FEF114B_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Fraction_float(float In, out float Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
            {
                Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_ChannelMask_RedGreen_float3 (float3 In, out float3 Out)
            {
                Out = float3(In.r, In.g, 0);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Normalize_float3(float3 In, out float3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Distance_float3(float3 A, float3 B, out float Out)
            {
                Out = distance(A, B);
            }
            
            void Unity_SceneColor_float(float4 UV, out float3 Out)
            {
                Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
            }
            
            void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Blend_Overwrite_float(float Base, float Blend, out float Out, float Opacity)
            {
                Out = lerp(Base, Blend, Opacity);
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float4 _SampleTexture2DLOD_35997DE_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_4ECADB09_Out_2, 0);
                float _SampleTexture2DLOD_35997DE_R_5 = _SampleTexture2DLOD_35997DE_RGBA_0.r;
                float _SampleTexture2DLOD_35997DE_G_6 = _SampleTexture2DLOD_35997DE_RGBA_0.g;
                float _SampleTexture2DLOD_35997DE_B_7 = _SampleTexture2DLOD_35997DE_RGBA_0.b;
                float _SampleTexture2DLOD_35997DE_A_8 = _SampleTexture2DLOD_35997DE_RGBA_0.a;
                float _Add_92BD554B_Out_2;
                Unity_Add_float(_SampleTexture2DLOD_35997DE_A_8, -0.25, _Add_92BD554B_Out_2);
                float _Property_6AEE6AD6_Out_0 = MacroWaveTessScale;
                float _Multiply_B04BDAD0_Out_2;
                Unity_Multiply_float(_Add_92BD554B_Out_2, _Property_6AEE6AD6_Out_0, _Multiply_B04BDAD0_Out_2);
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_FE512398_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_FE512398_Out_2);
                float4 _SampleTexture2DLOD_F6D4A02B_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_FE512398_Out_2, 0);
                float _SampleTexture2DLOD_F6D4A02B_R_5 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.r;
                float _SampleTexture2DLOD_F6D4A02B_G_6 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.g;
                float _SampleTexture2DLOD_F6D4A02B_B_7 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.b;
                float _SampleTexture2DLOD_F6D4A02B_A_8 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.a;
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_3D189493_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_3D189493_Out_2);
                float4 _SampleTexture2DLOD_CABCD0D0_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_3D189493_Out_2, 0);
                float _SampleTexture2DLOD_CABCD0D0_R_5 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.r;
                float _SampleTexture2DLOD_CABCD0D0_G_6 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.g;
                float _SampleTexture2DLOD_CABCD0D0_B_7 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.b;
                float _SampleTexture2DLOD_CABCD0D0_A_8 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.a;
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_B4922E7C_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_B4922E7C_Out_1);
                float _Lerp_DEF9BA7B_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_F6D4A02B_A_8, _SampleTexture2DLOD_CABCD0D0_A_8, _Absolute_B4922E7C_Out_1, _Lerp_DEF9BA7B_Out_3);
                float _Add_E7355D81_Out_2;
                Unity_Add_float(_Lerp_DEF9BA7B_Out_3, -0.25, _Add_E7355D81_Out_2);
                float _Property_57308837_Out_0 = _SlowWaterTessScale;
                float _Multiply_146A3378_Out_2;
                Unity_Multiply_float(_Add_E7355D81_Out_2, _Property_57308837_Out_0, _Multiply_146A3378_Out_2);
                float _Add_42AED159_Out_2;
                Unity_Add_float(_Multiply_B04BDAD0_Out_2, _Multiply_146A3378_Out_2, _Add_42AED159_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_C675255A_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_C675255A_Out_2);
                float4 _SampleTexture2DLOD_2BB41D12_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_C675255A_Out_2, 0);
                float _SampleTexture2DLOD_2BB41D12_R_5 = _SampleTexture2DLOD_2BB41D12_RGBA_0.r;
                float _SampleTexture2DLOD_2BB41D12_G_6 = _SampleTexture2DLOD_2BB41D12_RGBA_0.g;
                float _SampleTexture2DLOD_2BB41D12_B_7 = _SampleTexture2DLOD_2BB41D12_RGBA_0.b;
                float _SampleTexture2DLOD_2BB41D12_A_8 = _SampleTexture2DLOD_2BB41D12_RGBA_0.a;
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_89DE95D0_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_89DE95D0_Out_2);
                float4 _SampleTexture2DLOD_F0E303B2_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_89DE95D0_Out_2, 0);
                float _SampleTexture2DLOD_F0E303B2_R_5 = _SampleTexture2DLOD_F0E303B2_RGBA_0.r;
                float _SampleTexture2DLOD_F0E303B2_G_6 = _SampleTexture2DLOD_F0E303B2_RGBA_0.g;
                float _SampleTexture2DLOD_F0E303B2_B_7 = _SampleTexture2DLOD_F0E303B2_RGBA_0.b;
                float _SampleTexture2DLOD_F0E303B2_A_8 = _SampleTexture2DLOD_F0E303B2_RGBA_0.a;
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float _Lerp_4F958902_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_2BB41D12_A_8, _SampleTexture2DLOD_F0E303B2_A_8, _Absolute_D56AD49D_Out_1, _Lerp_4F958902_Out_3);
                float _Add_4C244952_Out_2;
                Unity_Add_float(_Lerp_4F958902_Out_3, -0.25, _Add_4C244952_Out_2);
                float _Property_A41EED02_Out_0 = _SmallCascadeWaterTessScale;
                float _Multiply_C6FA813B_Out_2;
                Unity_Multiply_float(_Add_4C244952_Out_2, _Property_A41EED02_Out_0, _Multiply_C6FA813B_Out_2);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float _Multiply_97C7958D_Out_2;
                Unity_Multiply_float(_Multiply_C6FA813B_Out_2, _Clamp_C9BB189_Out_3, _Multiply_97C7958D_Out_2);
                float _Add_B8D97A66_Out_2;
                Unity_Add_float(_Add_42AED159_Out_2, _Multiply_97C7958D_Out_2, _Add_B8D97A66_Out_2);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_260C289D_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_260C289D_Out_2);
                float4 _SampleTexture2DLOD_27B55B65_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_260C289D_Out_2, 0);
                float _SampleTexture2DLOD_27B55B65_R_5 = _SampleTexture2DLOD_27B55B65_RGBA_0.r;
                float _SampleTexture2DLOD_27B55B65_G_6 = _SampleTexture2DLOD_27B55B65_RGBA_0.g;
                float _SampleTexture2DLOD_27B55B65_B_7 = _SampleTexture2DLOD_27B55B65_RGBA_0.b;
                float _SampleTexture2DLOD_27B55B65_A_8 = _SampleTexture2DLOD_27B55B65_RGBA_0.a;
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_672C60ED_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_672C60ED_Out_2);
                float4 _SampleTexture2DLOD_4648E9_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_672C60ED_Out_2, 0);
                float _SampleTexture2DLOD_4648E9_R_5 = _SampleTexture2DLOD_4648E9_RGBA_0.r;
                float _SampleTexture2DLOD_4648E9_G_6 = _SampleTexture2DLOD_4648E9_RGBA_0.g;
                float _SampleTexture2DLOD_4648E9_B_7 = _SampleTexture2DLOD_4648E9_RGBA_0.b;
                float _SampleTexture2DLOD_4648E9_A_8 = _SampleTexture2DLOD_4648E9_RGBA_0.a;
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Lerp_1934036C_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_27B55B65_A_8, _SampleTexture2DLOD_4648E9_A_8, _Absolute_19D4C5A5_Out_1, _Lerp_1934036C_Out_3);
                float _Add_5F941B40_Out_2;
                Unity_Add_float(_Lerp_1934036C_Out_3, -0.25, _Add_5F941B40_Out_2);
                float _Property_D14DBA62_Out_0 = _BigCascadeWaterTessScale;
                float _Multiply_131F4390_Out_2;
                Unity_Multiply_float(_Add_5F941B40_Out_2, _Property_D14DBA62_Out_0, _Multiply_131F4390_Out_2);
                float _Multiply_F5B5CD1C_Out_2;
                Unity_Multiply_float(_Multiply_131F4390_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_F5B5CD1C_Out_2);
                float _Add_2878DA0E_Out_2;
                Unity_Add_float(_Add_B8D97A66_Out_2, _Multiply_F5B5CD1C_Out_2, _Add_2878DA0E_Out_2);
                float _Split_28662C1C_R_1 = IN.VertexColor[0];
                float _Split_28662C1C_G_2 = IN.VertexColor[1];
                float _Split_28662C1C_B_3 = IN.VertexColor[2];
                float _Split_28662C1C_A_4 = IN.VertexColor[3];
                float _Lerp_A69B24EB_Out_3;
                Unity_Lerp_float(_Add_2878DA0E_Out_2, _Add_42AED159_Out_2, _Split_28662C1C_R_1, _Lerp_A69B24EB_Out_3);
                float _Lerp_B24A0C56_Out_3;
                Unity_Lerp_float(_Lerp_A69B24EB_Out_3, _Multiply_97C7958D_Out_2, _Split_28662C1C_G_2, _Lerp_B24A0C56_Out_3);
                float _Lerp_5C765D8_Out_3;
                Unity_Lerp_float(_Lerp_B24A0C56_Out_3, _Multiply_131F4390_Out_2, _Split_28662C1C_B_3, _Lerp_5C765D8_Out_3);
                float3 _Multiply_238083B9_Out_2;
                Unity_Multiply_float(IN.ObjectSpaceNormal, (_Lerp_5C765D8_Out_3.xxx), _Multiply_238083B9_Out_2);
                float3 _Add_8A04BBE9_Out_2;
                Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_238083B9_Out_2, _Add_8A04BBE9_Out_2);
                description.VertexPosition = _Add_8A04BBE9_Out_2;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 WorldSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 ScreenPosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
                float FaceSign;
            };
            
            struct SurfaceDescription
            {
                float3 Albedo;
                float3 Normal;
                float3 Emission;
                float3 Specular;
                float Smoothness;
                float Occlusion;
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float4 _ScreenPosition_1B148032_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _Property_FC343CDD_Out_0 = _Distortion;
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_7772C3BA_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_7772C3BA_Out_2);
                float4 _SampleTexture2D_91308B7C_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_7772C3BA_Out_2);
                _SampleTexture2D_91308B7C_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_91308B7C_RGBA_0);
                float _SampleTexture2D_91308B7C_R_4 = _SampleTexture2D_91308B7C_RGBA_0.r;
                float _SampleTexture2D_91308B7C_G_5 = _SampleTexture2D_91308B7C_RGBA_0.g;
                float _SampleTexture2D_91308B7C_B_6 = _SampleTexture2D_91308B7C_RGBA_0.b;
                float _SampleTexture2D_91308B7C_A_7 = _SampleTexture2D_91308B7C_RGBA_0.a;
                float _Property_BE91B4F6_Out_0 = _SlowNormalScale;
                float3 _NormalStrength_528ACD86_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_91308B7C_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_528ACD86_Out_2);
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_C1F18389_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_C1F18389_Out_2);
                float4 _SampleTexture2D_4508A259_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_C1F18389_Out_2);
                _SampleTexture2D_4508A259_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_4508A259_RGBA_0);
                float _SampleTexture2D_4508A259_R_4 = _SampleTexture2D_4508A259_RGBA_0.r;
                float _SampleTexture2D_4508A259_G_5 = _SampleTexture2D_4508A259_RGBA_0.g;
                float _SampleTexture2D_4508A259_B_6 = _SampleTexture2D_4508A259_RGBA_0.b;
                float _SampleTexture2D_4508A259_A_7 = _SampleTexture2D_4508A259_RGBA_0.a;
                float3 _NormalStrength_3BD81F5D_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_4508A259_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_3BD81F5D_Out_2);
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_6685A82A_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_6685A82A_Out_1);
                float3 _Lerp_356E067F_Out_3;
                Unity_Lerp_float3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float2 _Property_6D8A3257_Out_0 = _MicroWaveTiling;
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Multiply_ABD9AE79_Out_2;
                Unity_Multiply_float(_Property_6D8A3257_Out_0, (_Property_AA95233A_Out_0.xx), _Multiply_ABD9AE79_Out_2);
                float2 _Divide_9BA6D0A0_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_ABD9AE79_Out_2, _Divide_9BA6D0A0_Out_2);
                float2 _Multiply_9E511F45_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_9BA6D0A0_Out_2, _Multiply_9E511F45_Out_2);
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float2 _Add_4F7464A_Out_2;
                Unity_Add_float2(_Multiply_9E511F45_Out_2, _Multiply_EA842EC4_Out_2, _Add_4F7464A_Out_2);
                float3 _ChannelMask_1D6B2B0B_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_356E067F_Out_3, _ChannelMask_1D6B2B0B_Out_1);
                float3 _Multiply_9233494E_Out_2;
                Unity_Multiply_float(_ChannelMask_1D6B2B0B_Out_1, float3(0.05, 0.05, 0), _Multiply_9233494E_Out_2);
                float2 _Add_3A640853_Out_2;
                Unity_Add_float2(_Add_4F7464A_Out_2, (_Multiply_9233494E_Out_2.xy), _Add_3A640853_Out_2);
                float4 _SampleTexture2D_F765A3FA_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_3A640853_Out_2);
                _SampleTexture2D_F765A3FA_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_F765A3FA_RGBA_0);
                float _SampleTexture2D_F765A3FA_R_4 = _SampleTexture2D_F765A3FA_RGBA_0.r;
                float _SampleTexture2D_F765A3FA_G_5 = _SampleTexture2D_F765A3FA_RGBA_0.g;
                float _SampleTexture2D_F765A3FA_B_6 = _SampleTexture2D_F765A3FA_RGBA_0.b;
                float _SampleTexture2D_F765A3FA_A_7 = _SampleTexture2D_F765A3FA_RGBA_0.a;
                float2 _Vector2_70672A35_Out_0 = float2(_SampleTexture2D_F765A3FA_R_4, _SampleTexture2D_F765A3FA_G_5);
                float3 _Sign_A4C02BB9_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_A4C02BB9_Out_1);
                float _Split_10A45667_R_1 = _Sign_A4C02BB9_Out_1[0];
                float _Split_10A45667_G_2 = _Sign_A4C02BB9_Out_1[1];
                float _Split_10A45667_B_3 = _Sign_A4C02BB9_Out_1[2];
                float _Split_10A45667_A_4 = 0;
                float2 _Vector2_C260D6C2_Out_0 = float2(_Split_10A45667_G_2, 1);
                float2 _Multiply_D4982FB9_Out_2;
                Unity_Multiply_float(_Vector2_70672A35_Out_0, _Vector2_C260D6C2_Out_0, _Multiply_D4982FB9_Out_2);
                float _Split_DCB9F46D_R_1 = IN.WorldSpaceNormal[0];
                float _Split_DCB9F46D_G_2 = IN.WorldSpaceNormal[1];
                float _Split_DCB9F46D_B_3 = IN.WorldSpaceNormal[2];
                float _Split_DCB9F46D_A_4 = 0;
                float2 _Vector2_8F37EEDE_Out_0 = float2(_Split_DCB9F46D_R_1, _Split_DCB9F46D_B_3);
                float2 _Add_EDD61406_Out_2;
                Unity_Add_float2(_Multiply_D4982FB9_Out_2, _Vector2_8F37EEDE_Out_0, _Add_EDD61406_Out_2);
                float _Split_DBEE69C5_R_1 = _Add_EDD61406_Out_2[0];
                float _Split_DBEE69C5_G_2 = _Add_EDD61406_Out_2[1];
                float _Split_DBEE69C5_B_3 = 0;
                float _Split_DBEE69C5_A_4 = 0;
                float _Multiply_19C907AA_Out_2;
                Unity_Multiply_float(_SampleTexture2D_F765A3FA_B_6, _Split_DCB9F46D_G_2, _Multiply_19C907AA_Out_2);
                float3 _Vector3_CC599D5F_Out_0 = float3(_Split_DBEE69C5_R_1, _Multiply_19C907AA_Out_2, _Split_DBEE69C5_G_2);
                float3x3 Transform_E097B73C_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_E097B73C_Out_1 = TransformWorldToTangent(_Vector3_CC599D5F_Out_0.xyz, Transform_E097B73C_tangentTransform_World);
                float3 _Normalize_6560E7A8_Out_1;
                Unity_Normalize_float3(_Transform_E097B73C_Out_1, _Normalize_6560E7A8_Out_1);
                float _Property_7246E682_Out_0 = _MicroWaveNormalScale;
                float3 _NormalStrength_E984BDF9_Out_2;
                Unity_NormalStrength_float(_Normalize_6560E7A8_Out_1, _Property_7246E682_Out_0, _NormalStrength_E984BDF9_Out_2);
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float2 _Add_B51BFC_Out_2;
                Unity_Add_float2(_Add_4ECADB09_Out_2, (_Multiply_9233494E_Out_2.xy), _Add_B51BFC_Out_2);
                float4 _SampleTexture2D_49A71497_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_B51BFC_Out_2);
                _SampleTexture2D_49A71497_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_49A71497_RGBA_0);
                float _SampleTexture2D_49A71497_R_4 = _SampleTexture2D_49A71497_RGBA_0.r;
                float _SampleTexture2D_49A71497_G_5 = _SampleTexture2D_49A71497_RGBA_0.g;
                float _SampleTexture2D_49A71497_B_6 = _SampleTexture2D_49A71497_RGBA_0.b;
                float _SampleTexture2D_49A71497_A_7 = _SampleTexture2D_49A71497_RGBA_0.a;
                float2 _Vector2_EE92CBEE_Out_0 = float2(_SampleTexture2D_49A71497_R_4, _SampleTexture2D_49A71497_G_5);
                float3 _Sign_CE4A6EE0_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_CE4A6EE0_Out_1);
                float _Split_717E3A76_R_1 = _Sign_CE4A6EE0_Out_1[0];
                float _Split_717E3A76_G_2 = _Sign_CE4A6EE0_Out_1[1];
                float _Split_717E3A76_B_3 = _Sign_CE4A6EE0_Out_1[2];
                float _Split_717E3A76_A_4 = 0;
                float2 _Vector2_43391560_Out_0 = float2(_Split_717E3A76_G_2, 1);
                float2 _Multiply_4D74E9F7_Out_2;
                Unity_Multiply_float(_Vector2_EE92CBEE_Out_0, _Vector2_43391560_Out_0, _Multiply_4D74E9F7_Out_2);
                float _Split_1E9BE17E_R_1 = IN.WorldSpaceNormal[0];
                float _Split_1E9BE17E_G_2 = IN.WorldSpaceNormal[1];
                float _Split_1E9BE17E_B_3 = IN.WorldSpaceNormal[2];
                float _Split_1E9BE17E_A_4 = 0;
                float2 _Vector2_7FB5264B_Out_0 = float2(_Split_1E9BE17E_R_1, _Split_1E9BE17E_B_3);
                float2 _Add_398D7267_Out_2;
                Unity_Add_float2(_Multiply_4D74E9F7_Out_2, _Vector2_7FB5264B_Out_0, _Add_398D7267_Out_2);
                float _Split_5414ACAC_R_1 = _Add_398D7267_Out_2[0];
                float _Split_5414ACAC_G_2 = _Add_398D7267_Out_2[1];
                float _Split_5414ACAC_B_3 = 0;
                float _Split_5414ACAC_A_4 = 0;
                float _Multiply_80133872_Out_2;
                Unity_Multiply_float(_SampleTexture2D_49A71497_B_6, _Split_1E9BE17E_G_2, _Multiply_80133872_Out_2);
                float3 _Vector3_336A482E_Out_0 = float3(_Split_5414ACAC_R_1, _Multiply_80133872_Out_2, _Split_5414ACAC_G_2);
                float3x3 Transform_5FC79949_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_5FC79949_Out_1 = TransformWorldToTangent(_Vector3_336A482E_Out_0.xyz, Transform_5FC79949_tangentTransform_World);
                float3 _Normalize_F8AB1C98_Out_1;
                Unity_Normalize_float3(_Transform_5FC79949_Out_1, _Normalize_F8AB1C98_Out_1);
                float _Property_EE02697B_Out_0 = _MacroWaveNormalScale;
                float3 _NormalStrength_3E2CC83C_Out_2;
                Unity_NormalStrength_float(_Normalize_F8AB1C98_Out_1, _Property_EE02697B_Out_0, _NormalStrength_3E2CC83C_Out_2);
                float3 _NormalBlend_942EAE7_Out_2;
                Unity_NormalBlend_float(_NormalStrength_E984BDF9_Out_2, _NormalStrength_3E2CC83C_Out_2, _NormalBlend_942EAE7_Out_2);
                float3 _NormalBlend_412E2B77_Out_2;
                Unity_NormalBlend_float(_Lerp_356E067F_Out_3, _NormalBlend_942EAE7_Out_2, _NormalBlend_412E2B77_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_188C8FD3_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_188C8FD3_Out_2);
                float4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeNormal, sampler_SmallCascadeNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                float _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                float _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                float _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                float _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                float _Property_8A81F679_Out_0 = _SmallCascadeNormalScale;
                float3 _NormalStrength_94FC33DB_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_AEBC8292_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_94FC33DB_Out_2);
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_3E5AC13E_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_3E5AC13E_Out_2);
                float4 _SampleTexture2D_9126225F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeNormal, sampler_SmallCascadeNormal, _Add_3E5AC13E_Out_2);
                _SampleTexture2D_9126225F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9126225F_RGBA_0);
                float _SampleTexture2D_9126225F_R_4 = _SampleTexture2D_9126225F_RGBA_0.r;
                float _SampleTexture2D_9126225F_G_5 = _SampleTexture2D_9126225F_RGBA_0.g;
                float _SampleTexture2D_9126225F_B_6 = _SampleTexture2D_9126225F_RGBA_0.b;
                float _SampleTexture2D_9126225F_A_7 = _SampleTexture2D_9126225F_RGBA_0.a;
                float3 _NormalStrength_337B983B_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_9126225F_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_337B983B_Out_2);
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float3 _Lerp_5B898C96_Out_3;
                Unity_Lerp_float3(_NormalStrength_94FC33DB_Out_2, _NormalStrength_337B983B_Out_2, (_Absolute_D56AD49D_Out_1.xxx), _Lerp_5B898C96_Out_3);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_float3(_NormalBlend_412E2B77_Out_2, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_D29A7CEF_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_D29A7CEF_Out_2);
                float4 _SampleTexture2D_6ABE710E_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascadeNormal, sampler_BigCascadeNormal, _Add_D29A7CEF_Out_2);
                _SampleTexture2D_6ABE710E_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6ABE710E_RGBA_0);
                float _SampleTexture2D_6ABE710E_R_4 = _SampleTexture2D_6ABE710E_RGBA_0.r;
                float _SampleTexture2D_6ABE710E_G_5 = _SampleTexture2D_6ABE710E_RGBA_0.g;
                float _SampleTexture2D_6ABE710E_B_6 = _SampleTexture2D_6ABE710E_RGBA_0.b;
                float _SampleTexture2D_6ABE710E_A_7 = _SampleTexture2D_6ABE710E_RGBA_0.a;
                float _Property_944CEF1C_Out_0 = _BigCascadeNormalScale;
                float3 _NormalStrength_8AA324A2_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_6ABE710E_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8AA324A2_Out_2);
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_47CB0CEA_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_47CB0CEA_Out_2);
                float4 _SampleTexture2D_6FC3A421_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascadeNormal, sampler_BigCascadeNormal, _Add_47CB0CEA_Out_2);
                _SampleTexture2D_6FC3A421_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6FC3A421_RGBA_0);
                float _SampleTexture2D_6FC3A421_R_4 = _SampleTexture2D_6FC3A421_RGBA_0.r;
                float _SampleTexture2D_6FC3A421_G_5 = _SampleTexture2D_6FC3A421_RGBA_0.g;
                float _SampleTexture2D_6FC3A421_B_6 = _SampleTexture2D_6FC3A421_RGBA_0.b;
                float _SampleTexture2D_6FC3A421_A_7 = _SampleTexture2D_6FC3A421_RGBA_0.a;
                float3 _NormalStrength_8264A1B8_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_6FC3A421_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8264A1B8_Out_2);
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float3 _Lerp_F884F066_Out_3;
                Unity_Lerp_float3(_NormalStrength_8AA324A2_Out_2, _NormalStrength_8264A1B8_Out_2, (_Absolute_19D4C5A5_Out_1.xxx), _Lerp_F884F066_Out_3);
                float3 _Lerp_C8A32E85_Out_3;
                Unity_Lerp_float3(_Lerp_BA2C71FD_Out_3, _Lerp_F884F066_Out_3, (_Clamp_C3D0E6D0_Out_3.xxx), _Lerp_C8A32E85_Out_3);
                float _Split_42E433A0_R_1 = IN.VertexColor[0];
                float _Split_42E433A0_G_2 = IN.VertexColor[1];
                float _Split_42E433A0_B_3 = IN.VertexColor[2];
                float _Split_42E433A0_A_4 = IN.VertexColor[3];
                float3 _Lerp_556A8C4B_Out_3;
                Unity_Lerp_float3(_Lerp_C8A32E85_Out_3, _NormalBlend_412E2B77_Out_2, (_Split_42E433A0_R_1.xxx), _Lerp_556A8C4B_Out_3);
                float3 _Lerp_CD3A5C6C_Out_3;
                Unity_Lerp_float3(_Lerp_556A8C4B_Out_3, _Lerp_5B898C96_Out_3, (_Split_42E433A0_G_2.xxx), _Lerp_CD3A5C6C_Out_3);
                float3 _Lerp_52D4237F_Out_3;
                Unity_Lerp_float3(_Lerp_CD3A5C6C_Out_3, _Lerp_F884F066_Out_3, (_Split_42E433A0_B_3.xxx), _Lerp_52D4237F_Out_3);
                float _Property_C2D9BD80_Out_0 = _FarNormalPower;
                float3 _Vector3_3A6917E5_Out_0 = float3(_Property_C2D9BD80_Out_0, _Property_C2D9BD80_Out_0, 1);
                float3 _Multiply_C66EC037_Out_2;
                Unity_Multiply_float(_Vector3_3A6917E5_Out_0, _Lerp_52D4237F_Out_3, _Multiply_C66EC037_Out_2);
                float _Distance_2BC7BAC4_Out_2;
                Unity_Distance_float3(IN.AbsoluteWorldSpacePosition, _WorldSpaceCameraPos, _Distance_2BC7BAC4_Out_2);
                float _Property_F830ADD1_Out_0 = _FarNormalBlendStartDistance;
                float _Divide_FD4E31CF_Out_2;
                Unity_Divide_float(_Distance_2BC7BAC4_Out_2, _Property_F830ADD1_Out_0, _Divide_FD4E31CF_Out_2);
                float _Absolute_C7759968_Out_1;
                Unity_Absolute_float(_Divide_FD4E31CF_Out_2, _Absolute_C7759968_Out_1);
                float _Property_793038B1_Out_0 = _FarNormalBlendThreshold;
                float _Power_B974F588_Out_2;
                Unity_Power_float(_Absolute_C7759968_Out_1, _Property_793038B1_Out_0, _Power_B974F588_Out_2);
                float _Clamp_92AA7C53_Out_3;
                Unity_Clamp_float(_Power_B974F588_Out_2, 0, 1, _Clamp_92AA7C53_Out_3);
                float3 _Lerp_72DCEC20_Out_3;
                Unity_Lerp_float3(_Lerp_52D4237F_Out_3, _Multiply_C66EC037_Out_2, (_Clamp_92AA7C53_Out_3.xxx), _Lerp_72DCEC20_Out_3);
                float3 _Normalize_17DCA406_Out_1;
                Unity_Normalize_float3(_Lerp_72DCEC20_Out_3, _Normalize_17DCA406_Out_1);
                float _Split_6A7D546B_R_1 = _Normalize_17DCA406_Out_1[0];
                float _Split_6A7D546B_G_2 = _Normalize_17DCA406_Out_1[1];
                float _Split_6A7D546B_B_3 = _Normalize_17DCA406_Out_1[2];
                float _Split_6A7D546B_A_4 = 0;
                float4 _Combine_E07639F2_RGBA_4;
                float3 _Combine_E07639F2_RGB_5;
                float2 _Combine_E07639F2_RG_6;
                Unity_Combine_float(_Split_6A7D546B_R_1, _Split_6A7D546B_G_2, 0, 0, _Combine_E07639F2_RGBA_4, _Combine_E07639F2_RGB_5, _Combine_E07639F2_RG_6);
                float2 _Multiply_2F7622D8_Out_2;
                Unity_Multiply_float((_Property_FC343CDD_Out_0.xx), _Combine_E07639F2_RG_6, _Multiply_2F7622D8_Out_2);
                float2 _Multiply_9F154179_Out_2;
                Unity_Multiply_float((_ScreenPosition_1B148032_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_9F154179_Out_2);
                float2 _Add_FCAE1710_Out_2;
                Unity_Add_float2((_ScreenPosition_1B148032_Out_0.xy), _Multiply_9F154179_Out_2, _Add_FCAE1710_Out_2);
                float3 _SceneColor_5A25EB33_Out_1;
                Unity_SceneColor_float((float4(_Add_FCAE1710_Out_2, 0.0, 1.0)), _SceneColor_5A25EB33_Out_1);
                float4 _Property_C4180B07_Out_0 = _DeepColor;
                float4 _Property_B354F529_Out_0 = _ShalowColor;
                float4 _ScreenPosition_E4782AF8_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_float(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                float _Multiply_39A1673A_Out_2;
                Unity_Multiply_float(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                float4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                float _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                float _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                float _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                float _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                float _Subtract_331D19CE_Out_2;
                Unity_Subtract_float(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                float _Property_46A80510_Out_0 = _ShalowFalloffMultiply;
                float _Multiply_55CDC796_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_46A80510_Out_0, _Multiply_55CDC796_Out_2);
                float _Absolute_DA749514_Out_1;
                Unity_Absolute_float(_Multiply_55CDC796_Out_2, _Absolute_DA749514_Out_1);
                float _Property_4D681D1C_Out_0 = _ShalowFalloffPower;
                float _Multiply_F7AB70ED_Out_2;
                Unity_Multiply_float(_Property_4D681D1C_Out_0, -1, _Multiply_F7AB70ED_Out_2);
                float _Power_3270BF29_Out_2;
                Unity_Power_float(_Absolute_DA749514_Out_1, _Multiply_F7AB70ED_Out_2, _Power_3270BF29_Out_2);
                float _Property_BB1D3A49_Out_0 = _BigCascadeTransparency;
                float _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_float(_Property_BB1D3A49_Out_0, _Clamp_C3D0E6D0_Out_3, _Multiply_6F5E4CCF_Out_2);
                float _Lerp_FE3B891E_Out_3;
                Unity_Lerp_float(_Power_3270BF29_Out_2, 100, _Multiply_6F5E4CCF_Out_2, _Lerp_FE3B891E_Out_3);
                float _Saturate_47EA3698_Out_1;
                Unity_Saturate_float(_Lerp_FE3B891E_Out_3, _Saturate_47EA3698_Out_1);
                float _Clamp_FA371D5_Out_3;
                Unity_Clamp_float(_Saturate_47EA3698_Out_1, 0, 1, _Clamp_FA371D5_Out_3);
                float4 _Lerp_E98C0337_Out_3;
                Unity_Lerp_float4(_Property_C4180B07_Out_0, _Property_B354F529_Out_0, (_Clamp_FA371D5_Out_3.xxxx), _Lerp_E98C0337_Out_3);
                float4 _SampleTexture2D_13F501DC_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_B51BFC_Out_2);
                float _SampleTexture2D_13F501DC_R_4 = _SampleTexture2D_13F501DC_RGBA_0.r;
                float _SampleTexture2D_13F501DC_G_5 = _SampleTexture2D_13F501DC_RGBA_0.g;
                float _SampleTexture2D_13F501DC_B_6 = _SampleTexture2D_13F501DC_RGBA_0.b;
                float _SampleTexture2D_13F501DC_A_7 = _SampleTexture2D_13F501DC_RGBA_0.a;
                float _Property_DF347AFD_Out_0 = _SlowWaterTranslucencyMultiply;
                float _Multiply_12D281E6_Out_2;
                Unity_Multiply_float(_SampleTexture2D_13F501DC_A_7, _Property_DF347AFD_Out_0, _Multiply_12D281E6_Out_2);
                float4 _SampleTexture2D_C713F57F_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_7772C3BA_Out_2);
                float _SampleTexture2D_C713F57F_R_4 = _SampleTexture2D_C713F57F_RGBA_0.r;
                float _SampleTexture2D_C713F57F_G_5 = _SampleTexture2D_C713F57F_RGBA_0.g;
                float _SampleTexture2D_C713F57F_B_6 = _SampleTexture2D_C713F57F_RGBA_0.b;
                float _SampleTexture2D_C713F57F_A_7 = _SampleTexture2D_C713F57F_RGBA_0.a;
                float4 _SampleTexture2D_5CD91024_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_C1F18389_Out_2);
                float _SampleTexture2D_5CD91024_R_4 = _SampleTexture2D_5CD91024_RGBA_0.r;
                float _SampleTexture2D_5CD91024_G_5 = _SampleTexture2D_5CD91024_RGBA_0.g;
                float _SampleTexture2D_5CD91024_B_6 = _SampleTexture2D_5CD91024_RGBA_0.b;
                float _SampleTexture2D_5CD91024_A_7 = _SampleTexture2D_5CD91024_RGBA_0.a;
                float _Lerp_AFD3E4F7_Out_3;
                Unity_Lerp_float(_SampleTexture2D_C713F57F_A_7, _SampleTexture2D_5CD91024_A_7, _Absolute_6685A82A_Out_1, _Lerp_AFD3E4F7_Out_3);
                float _Multiply_38871AB2_Out_2;
                Unity_Multiply_float(_Lerp_AFD3E4F7_Out_3, _Property_DF347AFD_Out_0, _Multiply_38871AB2_Out_2);
                float _Add_6B3A33E0_Out_2;
                Unity_Add_float(_Multiply_12D281E6_Out_2, _Multiply_38871AB2_Out_2, _Add_6B3A33E0_Out_2);
                float4 _SampleTexture2D_28CB720F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_188C8FD3_Out_2);
                float _SampleTexture2D_28CB720F_R_4 = _SampleTexture2D_28CB720F_RGBA_0.r;
                float _SampleTexture2D_28CB720F_G_5 = _SampleTexture2D_28CB720F_RGBA_0.g;
                float _SampleTexture2D_28CB720F_B_6 = _SampleTexture2D_28CB720F_RGBA_0.b;
                float _SampleTexture2D_28CB720F_A_7 = _SampleTexture2D_28CB720F_RGBA_0.a;
                float4 _SampleTexture2D_8FF1FC6F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_3E5AC13E_Out_2);
                float _SampleTexture2D_8FF1FC6F_R_4 = _SampleTexture2D_8FF1FC6F_RGBA_0.r;
                float _SampleTexture2D_8FF1FC6F_G_5 = _SampleTexture2D_8FF1FC6F_RGBA_0.g;
                float _SampleTexture2D_8FF1FC6F_B_6 = _SampleTexture2D_8FF1FC6F_RGBA_0.b;
                float _SampleTexture2D_8FF1FC6F_A_7 = _SampleTexture2D_8FF1FC6F_RGBA_0.a;
                float _Lerp_4087DCAB_Out_3;
                Unity_Lerp_float(_SampleTexture2D_28CB720F_A_7, _SampleTexture2D_8FF1FC6F_A_7, _Absolute_D56AD49D_Out_1, _Lerp_4087DCAB_Out_3);
                float _Multiply_886F60D0_Out_2;
                Unity_Multiply_float(_Lerp_4087DCAB_Out_3, _Clamp_C9BB189_Out_3, _Multiply_886F60D0_Out_2);
                float _Property_34EA6884_Out_0 = _SmallCascadeTranslucencyMultiply;
                float _Multiply_A5195DC2_Out_2;
                Unity_Multiply_float(_Multiply_886F60D0_Out_2, _Property_34EA6884_Out_0, _Multiply_A5195DC2_Out_2);
                float _Add_DB50B67C_Out_2;
                Unity_Add_float(_Add_6B3A33E0_Out_2, _Multiply_A5195DC2_Out_2, _Add_DB50B67C_Out_2);
                float4 _SampleTexture2D_3D04E744_RGBA_0 = SAMPLE_TEXTURE2D(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_D29A7CEF_Out_2);
                float _SampleTexture2D_3D04E744_R_4 = _SampleTexture2D_3D04E744_RGBA_0.r;
                float _SampleTexture2D_3D04E744_G_5 = _SampleTexture2D_3D04E744_RGBA_0.g;
                float _SampleTexture2D_3D04E744_B_6 = _SampleTexture2D_3D04E744_RGBA_0.b;
                float _SampleTexture2D_3D04E744_A_7 = _SampleTexture2D_3D04E744_RGBA_0.a;
                float4 _SampleTexture2D_FDC3D2E_RGBA_0 = SAMPLE_TEXTURE2D(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_47CB0CEA_Out_2);
                float _SampleTexture2D_FDC3D2E_R_4 = _SampleTexture2D_FDC3D2E_RGBA_0.r;
                float _SampleTexture2D_FDC3D2E_G_5 = _SampleTexture2D_FDC3D2E_RGBA_0.g;
                float _SampleTexture2D_FDC3D2E_B_6 = _SampleTexture2D_FDC3D2E_RGBA_0.b;
                float _SampleTexture2D_FDC3D2E_A_7 = _SampleTexture2D_FDC3D2E_RGBA_0.a;
                float _Lerp_627AFBE_Out_3;
                Unity_Lerp_float(_SampleTexture2D_3D04E744_A_7, _SampleTexture2D_FDC3D2E_A_7, _Absolute_19D4C5A5_Out_1, _Lerp_627AFBE_Out_3);
                float _Property_928C8D62_Out_0 = _BigCascadeTranslucencyMultiply;
                float _Multiply_5E3A9C4F_Out_2;
                Unity_Multiply_float(_Lerp_627AFBE_Out_3, _Property_928C8D62_Out_0, _Multiply_5E3A9C4F_Out_2);
                float _Multiply_985131BF_Out_2;
                Unity_Multiply_float(_Multiply_5E3A9C4F_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_985131BF_Out_2);
                float _Add_48913743_Out_2;
                Unity_Add_float(_Add_DB50B67C_Out_2, _Multiply_985131BF_Out_2, _Add_48913743_Out_2);
                float _Lerp_9F2FC6DE_Out_3;
                Unity_Lerp_float(_Add_48913743_Out_2, _Add_6B3A33E0_Out_2, _Split_42E433A0_R_1, _Lerp_9F2FC6DE_Out_3);
                float _Lerp_FB484DB5_Out_3;
                Unity_Lerp_float(_Lerp_9F2FC6DE_Out_3, _Multiply_A5195DC2_Out_2, _Split_42E433A0_G_2, _Lerp_FB484DB5_Out_3);
                float _Lerp_895F9AAF_Out_3;
                Unity_Lerp_float(_Lerp_FB484DB5_Out_3, _Multiply_985131BF_Out_2, _Split_42E433A0_B_3, _Lerp_895F9AAF_Out_3);
                float _Property_34B150E6_Out_0 = _WaveTranslucencyHardness;
                float _Multiply_814E887D_Out_2;
                Unity_Multiply_float(_Lerp_895F9AAF_Out_3, _Property_34B150E6_Out_0, _Multiply_814E887D_Out_2);
                float _Absolute_48E4873A_Out_1;
                Unity_Absolute_float(_Multiply_814E887D_Out_2, _Absolute_48E4873A_Out_1);
                float _Property_9EFC9ABB_Out_0 = _WaveTranslucencyPower;
                float _Power_4A7A9922_Out_2;
                Unity_Power_float(_Absolute_48E4873A_Out_1, _Property_9EFC9ABB_Out_0, _Power_4A7A9922_Out_2);
                float _Property_CC520751_Out_0 = _WaveTranslucencyMultiply;
                float _Multiply_A80435F6_Out_2;
                Unity_Multiply_float(_Power_4A7A9922_Out_2, _Property_CC520751_Out_0, _Multiply_A80435F6_Out_2);
                float _Property_4A52B221_Out_0 = _WaveTranslucencyFallOffDistance;
                float _Divide_9A2ADE25_Out_2;
                Unity_Divide_float(_Distance_2BC7BAC4_Out_2, _Property_4A52B221_Out_0, _Divide_9A2ADE25_Out_2);
                float _Lerp_2EB5E047_Out_3;
                Unity_Lerp_float(_Multiply_A80435F6_Out_2, 0, _Divide_9A2ADE25_Out_2, _Lerp_2EB5E047_Out_3);
                float _Clamp_844D27EC_Out_3;
                Unity_Clamp_float(_Lerp_2EB5E047_Out_3, 0, 1, _Clamp_844D27EC_Out_3);
                float4 _Lerp_B4C04BFD_Out_3;
                Unity_Lerp_float4(_Lerp_E98C0337_Out_3, _Property_B354F529_Out_0, (_Clamp_844D27EC_Out_3.xxxx), _Lerp_B4C04BFD_Out_3);
                float3 _Multiply_D633B72E_Out_2;
                Unity_Multiply_float((_Lerp_B4C04BFD_Out_3.xyz), _SceneColor_5A25EB33_Out_1, _Multiply_D633B72E_Out_2);
                float _Property_6D149C33_Out_0 = _WaterAlphaMultiply;
                float _Multiply_BFF3EB6E_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_6D149C33_Out_0, _Multiply_BFF3EB6E_Out_2);
                float _Clamp_D42DB1DE_Out_3;
                Unity_Clamp_float(_Multiply_BFF3EB6E_Out_2, 0, 1, _Clamp_D42DB1DE_Out_3);
                float _Property_BF7B7D6B_Out_0 = _WaterAlphaPower;
                float _Power_84CE25F5_Out_2;
                Unity_Power_float(_Clamp_D42DB1DE_Out_3, _Property_BF7B7D6B_Out_0, _Power_84CE25F5_Out_2);
                float _Clamp_F8CBC0B_Out_3;
                Unity_Clamp_float(_Power_84CE25F5_Out_2, 0, 1, _Clamp_F8CBC0B_Out_3);
                float3 _Lerp_E9A0ECDE_Out_3;
                Unity_Lerp_float3(_Multiply_D633B72E_Out_2, (_Lerp_B4C04BFD_Out_3.xyz), (_Clamp_F8CBC0B_Out_3.xxx), _Lerp_E9A0ECDE_Out_3);
                float _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                float _Multiply_312FB549_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                float _Clamp_43A46A4A_Out_3;
                Unity_Clamp_float(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                float _Absolute_97151155_Out_1;
                Unity_Absolute_float(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                float _Property_D7C9F55F_Out_0 = _CleanFalloffPower;
                float _Power_AD928E85_Out_2;
                Unity_Power_float(_Absolute_97151155_Out_1, _Property_D7C9F55F_Out_0, _Power_AD928E85_Out_2);
                float _Clamp_9B4149BD_Out_3;
                Unity_Clamp_float(_Power_AD928E85_Out_2, 0, 1, _Clamp_9B4149BD_Out_3);
                float3 _Lerp_DF8F6DB6_Out_3;
                Unity_Lerp_float3(_SceneColor_5A25EB33_Out_1, _Lerp_E9A0ECDE_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_DF8F6DB6_Out_3);
                float3 _Property_71824DF9_Out_0 = _FoamColor;
                float _Property_6A3E12E9_Out_0 = _FoamDepth;
                float _Add_D65144A5_Out_2;
                Unity_Add_float(_Subtract_331D19CE_Out_2, _Property_6A3E12E9_Out_0, _Add_D65144A5_Out_2);
                float _Absolute_236EA369_Out_1;
                Unity_Absolute_float(_Add_D65144A5_Out_2, _Absolute_236EA369_Out_1);
                float _Property_5092872F_Out_0 = _FoamFalloff;
                float _Power_C278752C_Out_2;
                Unity_Power_float(_Absolute_236EA369_Out_1, _Property_5092872F_Out_0, _Power_C278752C_Out_2);
                float _Saturate_F768EEA6_Out_1;
                Unity_Saturate_float(_Power_C278752C_Out_2, _Saturate_F768EEA6_Out_1);
                float _Property_A8CF8708_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_25764F01_Out_0 = _FoamSpeed;
                float2 _Property_3E47978_Out_0 = _FoamTiling;
                float2 _Multiply_DE80E1D6_Out_2;
                Unity_Multiply_float(_Property_25764F01_Out_0, _Property_3E47978_Out_0, _Multiply_DE80E1D6_Out_2);
                float4 _UV_E1385FB5_Out_0 = IN.uv3;
                float2 _Multiply_3C9DE3D3_Out_2;
                Unity_Multiply_float(_Multiply_DE80E1D6_Out_2, (_UV_E1385FB5_Out_0.xy), _Multiply_3C9DE3D3_Out_2);
                float _Split_90264A5B_R_1 = _Multiply_3C9DE3D3_Out_2[0];
                float _Split_90264A5B_G_2 = _Multiply_3C9DE3D3_Out_2[1];
                float _Split_90264A5B_B_3 = 0;
                float _Split_90264A5B_A_4 = 0;
                float2 _Vector2_8C003284_Out_0 = float2(_Split_90264A5B_G_2, _Split_90264A5B_R_1);
                float2 _Branch_81C13B1A_Out_3;
                Unity_Branch_float2(_Property_A8CF8708_Out_0, _Multiply_3C9DE3D3_Out_2, _Vector2_8C003284_Out_0, _Branch_81C13B1A_Out_3);
                float2 _Multiply_F37F0047_Out_2;
                Unity_Multiply_float(_Branch_81C13B1A_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_F37F0047_Out_2);
                float _Property_70842CE7_Out_0 = _GlobalTiling;
                float _Divide_D13271E5_Out_2;
                Unity_Divide_float(1, _Property_70842CE7_Out_0, _Divide_D13271E5_Out_2);
                float4 _UV_E210B498_Out_0 = IN.uv0;
                float2 _Multiply_38B9004E_Out_2;
                Unity_Multiply_float(_Property_3E47978_Out_0, (_UV_E210B498_Out_0.xy), _Multiply_38B9004E_Out_2);
                float2 _Multiply_FED7B7C8_Out_2;
                Unity_Multiply_float((_Divide_D13271E5_Out_2.xx), _Multiply_38B9004E_Out_2, _Multiply_FED7B7C8_Out_2);
                float2 _Add_F1148D00_Out_2;
                Unity_Add_float2(_Multiply_F37F0047_Out_2, _Multiply_FED7B7C8_Out_2, _Add_F1148D00_Out_2);
                float3 _ChannelMask_70068C75_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_BA2C71FD_Out_3, _ChannelMask_70068C75_Out_1);
                float3 _Multiply_134985D4_Out_2;
                Unity_Multiply_float(_ChannelMask_70068C75_Out_1, float3(0.03, 0.03, 0), _Multiply_134985D4_Out_2);
                float2 _Add_C3A54034_Out_2;
                Unity_Add_float2(_Add_F1148D00_Out_2, (_Multiply_134985D4_Out_2.xy), _Add_C3A54034_Out_2);
                float4 _SampleTexture2D_D6FF940D_RGBA_0 = SAMPLE_TEXTURE2D(_Foam, sampler_Foam, _Add_C3A54034_Out_2);
                float _SampleTexture2D_D6FF940D_R_4 = _SampleTexture2D_D6FF940D_RGBA_0.r;
                float _SampleTexture2D_D6FF940D_G_5 = _SampleTexture2D_D6FF940D_RGBA_0.g;
                float _SampleTexture2D_D6FF940D_B_6 = _SampleTexture2D_D6FF940D_RGBA_0.b;
                float _SampleTexture2D_D6FF940D_A_7 = _SampleTexture2D_D6FF940D_RGBA_0.a;
                float2 _Multiply_3FB3476F_Out_2;
                Unity_Multiply_float(_Branch_81C13B1A_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_3FB3476F_Out_2);
                float2 _Add_7633CAE7_Out_2;
                Unity_Add_float2(_Multiply_FED7B7C8_Out_2, _Multiply_3FB3476F_Out_2, _Add_7633CAE7_Out_2);
                float2 _Add_14D7BEE1_Out_2;
                Unity_Add_float2(_Add_7633CAE7_Out_2, (_Multiply_134985D4_Out_2.xy), _Add_14D7BEE1_Out_2);
                float4 _SampleTexture2D_80481243_RGBA_0 = SAMPLE_TEXTURE2D(_Foam, sampler_Foam, _Add_14D7BEE1_Out_2);
                float _SampleTexture2D_80481243_R_4 = _SampleTexture2D_80481243_RGBA_0.r;
                float _SampleTexture2D_80481243_G_5 = _SampleTexture2D_80481243_RGBA_0.g;
                float _SampleTexture2D_80481243_B_6 = _SampleTexture2D_80481243_RGBA_0.b;
                float _SampleTexture2D_80481243_A_7 = _SampleTexture2D_80481243_RGBA_0.a;
                float _Lerp_408AE005_Out_3;
                Unity_Lerp_float(_SampleTexture2D_D6FF940D_A_7, _SampleTexture2D_80481243_A_7, _Absolute_6685A82A_Out_1, _Lerp_408AE005_Out_3);
                float _Multiply_CE5D1661_Out_2;
                Unity_Multiply_float(_Saturate_F768EEA6_Out_1, _Lerp_408AE005_Out_3, _Multiply_CE5D1661_Out_2);
                float _Lerp_25030EB5_Out_3;
                Unity_Lerp_float(_Multiply_CE5D1661_Out_2, 0, _Clamp_C3D0E6D0_Out_3, _Lerp_25030EB5_Out_3);
                float _Clamp_CDFBCC47_Out_3;
                Unity_Clamp_float(_Lerp_25030EB5_Out_3, 0, 1, _Clamp_CDFBCC47_Out_3);
                float _Property_C10720A6_Out_0 = _FoamWaveHardness;
                float _Multiply_E0985C9B_Out_2;
                Unity_Multiply_float(_Lerp_AFD3E4F7_Out_3, _Property_C10720A6_Out_0, _Multiply_E0985C9B_Out_2);
                float _Absolute_47BFD663_Out_1;
                Unity_Absolute_float(_Multiply_E0985C9B_Out_2, _Absolute_47BFD663_Out_1);
                float _Property_7556FCA1_Out_0 = _FoamWavePower;
                float _Power_E4C90FA4_Out_2;
                Unity_Power_float(_Absolute_47BFD663_Out_1, _Property_7556FCA1_Out_0, _Power_E4C90FA4_Out_2);
                float _Property_C5E24EE_Out_0 = _FoamWaveMultiply;
                float _Multiply_49E6B3AD_Out_2;
                Unity_Multiply_float(_Power_E4C90FA4_Out_2, _Property_C5E24EE_Out_0, _Multiply_49E6B3AD_Out_2);
                float _Clamp_41A39F5E_Out_3;
                Unity_Clamp_float(_Multiply_49E6B3AD_Out_2, 0, 1, _Clamp_41A39F5E_Out_3);
                float _Multiply_6E6B7134_Out_2;
                Unity_Multiply_float(_Clamp_CDFBCC47_Out_3, _Clamp_41A39F5E_Out_3, _Multiply_6E6B7134_Out_2);
                float3 _Lerp_6998DF58_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Property_71824DF9_Out_0, (_Multiply_6E6B7134_Out_2.xxx), _Lerp_6998DF58_Out_3);
                float4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascade, sampler_SmallCascade, _Add_188C8FD3_Out_2);
                float _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                float _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                float _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                float _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                float4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascade, sampler_SmallCascade, _Add_3E5AC13E_Out_2);
                float _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                float _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                float _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                float _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                float _Blend_A1B262EF_Out_2;
                Unity_Blend_Overwrite_float(_SampleTexture2D_B8ACE3F1_A_7, _SampleTexture2D_A1621BBD_A_7, _Blend_A1B262EF_Out_2, _Absolute_D56AD49D_Out_1);
                float _Property_50DF1CAB_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_A4A55C8D_Out_0 = _NoiseSpeed;
                float2 _Property_986C2E1B_Out_0 = _NoiseTiling;
                float2 _Multiply_778A9500_Out_2;
                Unity_Multiply_float(_Property_A4A55C8D_Out_0, _Property_986C2E1B_Out_0, _Multiply_778A9500_Out_2);
                float4 _UV_4A477E20_Out_0 = IN.uv3;
                float2 _Multiply_E53528CB_Out_2;
                Unity_Multiply_float(_Multiply_778A9500_Out_2, (_UV_4A477E20_Out_0.xy), _Multiply_E53528CB_Out_2);
                float _Split_A3C5F2B5_R_1 = _Multiply_E53528CB_Out_2[0];
                float _Split_A3C5F2B5_G_2 = _Multiply_E53528CB_Out_2[1];
                float _Split_A3C5F2B5_B_3 = 0;
                float _Split_A3C5F2B5_A_4 = 0;
                float2 _Vector2_6D67D273_Out_0 = float2(_Split_A3C5F2B5_G_2, _Split_A3C5F2B5_R_1);
                float2 _Branch_EDA2C0E3_Out_3;
                Unity_Branch_float2(_Property_50DF1CAB_Out_0, _Multiply_E53528CB_Out_2, _Vector2_6D67D273_Out_0, _Branch_EDA2C0E3_Out_3);
                float _Fraction_2FBB1852_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_2FBB1852_Out_1);
                float2 _Multiply_39A54641_Out_2;
                Unity_Multiply_float(_Branch_EDA2C0E3_Out_3, (_Fraction_2FBB1852_Out_1.xx), _Multiply_39A54641_Out_2);
                float _Property_82193ED3_Out_0 = _GlobalTiling;
                float _Divide_411EED11_Out_2;
                Unity_Divide_float(1, _Property_82193ED3_Out_0, _Divide_411EED11_Out_2);
                float4 _UV_F9D3A262_Out_0 = IN.uv0;
                float2 _Multiply_9C31F9C2_Out_2;
                Unity_Multiply_float(_Property_986C2E1B_Out_0, (_UV_F9D3A262_Out_0.xy), _Multiply_9C31F9C2_Out_2);
                float2 _Multiply_E6E2F026_Out_2;
                Unity_Multiply_float((_Divide_411EED11_Out_2.xx), _Multiply_9C31F9C2_Out_2, _Multiply_E6E2F026_Out_2);
                float2 _Add_BADC8439_Out_2;
                Unity_Add_float2(_Multiply_39A54641_Out_2, _Multiply_E6E2F026_Out_2, _Add_BADC8439_Out_2);
                float3 _ChannelMask_CFDD80FE_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_BA2C71FD_Out_3, _ChannelMask_CFDD80FE_Out_1);
                float3 _Multiply_A40BA8F9_Out_2;
                Unity_Multiply_float(_ChannelMask_CFDD80FE_Out_1, float3(0.03, 0.03, 0), _Multiply_A40BA8F9_Out_2);
                float2 _Add_6D99D51F_Out_2;
                Unity_Add_float2(_Add_BADC8439_Out_2, (_Multiply_A40BA8F9_Out_2.xy), _Add_6D99D51F_Out_2);
                float4 _SampleTexture2D_D803AB07_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_6D99D51F_Out_2);
                float _SampleTexture2D_D803AB07_R_4 = _SampleTexture2D_D803AB07_RGBA_0.r;
                float _SampleTexture2D_D803AB07_G_5 = _SampleTexture2D_D803AB07_RGBA_0.g;
                float _SampleTexture2D_D803AB07_B_6 = _SampleTexture2D_D803AB07_RGBA_0.b;
                float _SampleTexture2D_D803AB07_A_7 = _SampleTexture2D_D803AB07_RGBA_0.a;
                float _Fraction_F51ED0A1_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_F51ED0A1_Out_1);
                float2 _Multiply_EEA6AA5B_Out_2;
                Unity_Multiply_float(_Branch_EDA2C0E3_Out_3, (_Fraction_F51ED0A1_Out_1.xx), _Multiply_EEA6AA5B_Out_2);
                float2 _Add_9509D7CE_Out_2;
                Unity_Add_float2(_Multiply_E6E2F026_Out_2, _Multiply_EEA6AA5B_Out_2, _Add_9509D7CE_Out_2);
                float2 _Add_3E9F55C4_Out_2;
                Unity_Add_float2(_Add_9509D7CE_Out_2, (_Multiply_A40BA8F9_Out_2.xy), _Add_3E9F55C4_Out_2);
                float4 _SampleTexture2D_198CC76A_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_3E9F55C4_Out_2);
                float _SampleTexture2D_198CC76A_R_4 = _SampleTexture2D_198CC76A_RGBA_0.r;
                float _SampleTexture2D_198CC76A_G_5 = _SampleTexture2D_198CC76A_RGBA_0.g;
                float _SampleTexture2D_198CC76A_B_6 = _SampleTexture2D_198CC76A_RGBA_0.b;
                float _SampleTexture2D_198CC76A_A_7 = _SampleTexture2D_198CC76A_RGBA_0.a;
                float _Lerp_51CEF3BF_Out_3;
                Unity_Lerp_float(_SampleTexture2D_D803AB07_A_7, _SampleTexture2D_198CC76A_A_7, _Absolute_D56AD49D_Out_1, _Lerp_51CEF3BF_Out_3);
                float _Absolute_38E6503D_Out_1;
                Unity_Absolute_float(_Lerp_51CEF3BF_Out_3, _Absolute_38E6503D_Out_1);
                float _Property_C1134212_Out_0 = _SmallCascadeNoisePower;
                float _Power_483D9151_Out_2;
                Unity_Power_float(_Absolute_38E6503D_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                float _Property_8B0E8794_Out_0 = _SmallCascadeNoiseMultiply;
                float _Multiply_E26A26BB_Out_2;
                Unity_Multiply_float(_Power_483D9151_Out_2, _Property_8B0E8794_Out_0, _Multiply_E26A26BB_Out_2);
                float _Clamp_805729EB_Out_3;
                Unity_Clamp_float(_Multiply_E26A26BB_Out_2, 0, 1, _Clamp_805729EB_Out_3);
                float _Lerp_39572874_Out_3;
                Unity_Lerp_float(0, _Blend_A1B262EF_Out_2, _Clamp_805729EB_Out_3, _Lerp_39572874_Out_3);
                float3 _Property_4A612457_Out_0 = _SmallCascadeColor;
                float3 _Multiply_E85EE897_Out_2;
                Unity_Multiply_float((_Lerp_39572874_Out_3.xxx), _Property_4A612457_Out_0, _Multiply_E85EE897_Out_2);
                float _Absolute_5DF2B9D0_Out_1;
                Unity_Absolute_float(_Blend_A1B262EF_Out_2, _Absolute_5DF2B9D0_Out_1);
                float _Property_97A26DCC_Out_0 = _SmallCascadeFoamFalloff;
                float _Power_328AD5E3_Out_2;
                Unity_Power_float(_Absolute_5DF2B9D0_Out_1, _Property_97A26DCC_Out_0, _Power_328AD5E3_Out_2);
                float _Clamp_33692D9C_Out_3;
                Unity_Clamp_float(_Power_328AD5E3_Out_2, 0, 1, _Clamp_33692D9C_Out_3);
                float _Lerp_8877E3D4_Out_3;
                Unity_Lerp_float(0, _Clamp_33692D9C_Out_3, _Clamp_C9BB189_Out_3, _Lerp_8877E3D4_Out_3);
                float3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_float3(_Lerp_6998DF58_Out_3, _Multiply_E85EE897_Out_2, (_Lerp_8877E3D4_Out_3.xxx), _Lerp_4F98523C_Out_3);
                float4 _SampleTexture2D_387AEB22_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascade, sampler_BigCascade, _Add_D29A7CEF_Out_2);
                float _SampleTexture2D_387AEB22_R_4 = _SampleTexture2D_387AEB22_RGBA_0.r;
                float _SampleTexture2D_387AEB22_G_5 = _SampleTexture2D_387AEB22_RGBA_0.g;
                float _SampleTexture2D_387AEB22_B_6 = _SampleTexture2D_387AEB22_RGBA_0.b;
                float _SampleTexture2D_387AEB22_A_7 = _SampleTexture2D_387AEB22_RGBA_0.a;
                float4 _SampleTexture2D_9FEF114B_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascade, sampler_BigCascade, _Add_47CB0CEA_Out_2);
                float _SampleTexture2D_9FEF114B_R_4 = _SampleTexture2D_9FEF114B_RGBA_0.r;
                float _SampleTexture2D_9FEF114B_G_5 = _SampleTexture2D_9FEF114B_RGBA_0.g;
                float _SampleTexture2D_9FEF114B_B_6 = _SampleTexture2D_9FEF114B_RGBA_0.b;
                float _SampleTexture2D_9FEF114B_A_7 = _SampleTexture2D_9FEF114B_RGBA_0.a;
                float _Blend_FAB812B4_Out_2;
                Unity_Blend_Overwrite_float(_SampleTexture2D_387AEB22_A_7, _SampleTexture2D_9FEF114B_A_7, _Blend_FAB812B4_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Multiply_2D163AB3_Out_2;
                Unity_Multiply_float(0.5, _Blend_FAB812B4_Out_2, _Multiply_2D163AB3_Out_2);
                float _Property_5515474F_Out_0 = _BigCascadeNoisePower;
                float _Power_E5773568_Out_2;
                Unity_Power_float(_Absolute_38E6503D_Out_1, _Property_5515474F_Out_0, _Power_E5773568_Out_2);
                float _Property_2C8FB0D9_Out_0 = _BigCascadeNoiseMultiply;
                float _Multiply_9128FAF6_Out_2;
                Unity_Multiply_float(_Power_E5773568_Out_2, _Property_2C8FB0D9_Out_0, _Multiply_9128FAF6_Out_2);
                float _Clamp_1E99CDDE_Out_3;
                Unity_Clamp_float(_Multiply_9128FAF6_Out_2, 0, 1, _Clamp_1E99CDDE_Out_3);
                float _Lerp_50210667_Out_3;
                Unity_Lerp_float(_Multiply_2D163AB3_Out_2, _Blend_FAB812B4_Out_2, _Clamp_1E99CDDE_Out_3, _Lerp_50210667_Out_3);
                float3 _Property_DB02E9C9_Out_0 = _BigCascadeColor;
                float3 _Multiply_630AB59_Out_2;
                Unity_Multiply_float((_Lerp_50210667_Out_3.xxx), _Property_DB02E9C9_Out_0, _Multiply_630AB59_Out_2);
                float _Absolute_E807A97_Out_1;
                Unity_Absolute_float(_Blend_FAB812B4_Out_2, _Absolute_E807A97_Out_1);
                float _Property_97864BE9_Out_0 = Big_Cascade_Foam_Falloff;
                float _Power_F37DBF08_Out_2;
                Unity_Power_float(_Absolute_E807A97_Out_1, _Property_97864BE9_Out_0, _Power_F37DBF08_Out_2);
                float _Clamp_142C06F9_Out_3;
                Unity_Clamp_float(_Power_F37DBF08_Out_2, 0, 1, _Clamp_142C06F9_Out_3);
                float _Lerp_6316FED8_Out_3;
                Unity_Lerp_float(0, _Clamp_142C06F9_Out_3, _Clamp_C3D0E6D0_Out_3, _Lerp_6316FED8_Out_3);
                float3 _Lerp_96C773B7_Out_3;
                Unity_Lerp_float3(_Lerp_4F98523C_Out_3, _Multiply_630AB59_Out_2, (_Lerp_6316FED8_Out_3.xxx), _Lerp_96C773B7_Out_3);
                float3 _Lerp_8DC18263_Out_3;
                Unity_Lerp_float3(_Lerp_96C773B7_Out_3, _Lerp_DF8F6DB6_Out_3, (_Split_42E433A0_R_1.xxx), _Lerp_8DC18263_Out_3);
                float3 _Lerp_39AFE3C2_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Multiply_E85EE897_Out_2, (_Clamp_33692D9C_Out_3.xxx), _Lerp_39AFE3C2_Out_3);
                float3 _Lerp_78BD1AA8_Out_3;
                Unity_Lerp_float3(_Lerp_8DC18263_Out_3, _Lerp_39AFE3C2_Out_3, (_Split_42E433A0_G_2.xxx), _Lerp_78BD1AA8_Out_3);
                float3 _Lerp_8E1AA6D9_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Multiply_630AB59_Out_2, (_Clamp_142C06F9_Out_3.xxx), _Lerp_8E1AA6D9_Out_3);
                float3 _Lerp_EE19DF0F_Out_3;
                Unity_Lerp_float3(_Lerp_78BD1AA8_Out_3, _Lerp_8E1AA6D9_Out_3, (_Split_42E433A0_B_3.xxx), _Lerp_EE19DF0F_Out_3);
                float _Property_94D7B381_Out_0 = _WaterSpecularFar;
                float _Property_C56737D2_Out_0 = _WaterSpecularClose;
                float _Absolute_671034E1_Out_1;
                Unity_Absolute_float(_Clamp_FA371D5_Out_3, _Absolute_671034E1_Out_1);
                float _Property_E3DB516C_Out_0 = _WaterSpecularThreshold;
                float _Power_B3799F13_Out_2;
                Unity_Power_float(_Absolute_671034E1_Out_1, _Property_E3DB516C_Out_0, _Power_B3799F13_Out_2);
                float _Lerp_66D4299C_Out_3;
                Unity_Lerp_float(_Property_94D7B381_Out_0, _Property_C56737D2_Out_0, _Power_B3799F13_Out_2, _Lerp_66D4299C_Out_3);
                float _Property_8EBC0BEE_Out_0 = _FoamSpecular;
                float _Lerp_F3EE6DD2_Out_3;
                Unity_Lerp_float(_Lerp_66D4299C_Out_3, _Property_8EBC0BEE_Out_0, _Multiply_6E6B7134_Out_2, _Lerp_F3EE6DD2_Out_3);
                float _Property_856E8F87_Out_0 = _SmallCascadeSpecular;
                float _Lerp_EEBEB2D3_Out_3;
                Unity_Lerp_float(_Lerp_F3EE6DD2_Out_3, _Property_856E8F87_Out_0, _Lerp_8877E3D4_Out_3, _Lerp_EEBEB2D3_Out_3);
                float _Property_DBC540D0_Out_0 = _BigCascadeSpecular;
                float _Lerp_3A2D7012_Out_3;
                Unity_Lerp_float(_Lerp_EEBEB2D3_Out_3, _Property_DBC540D0_Out_0, _Lerp_6316FED8_Out_3, _Lerp_3A2D7012_Out_3);
                float _Lerp_6F531387_Out_3;
                Unity_Lerp_float(_Lerp_3A2D7012_Out_3, _Lerp_66D4299C_Out_3, _Split_42E433A0_R_1, _Lerp_6F531387_Out_3);
                float _Lerp_E29FCC84_Out_3;
                Unity_Lerp_float(_Lerp_66D4299C_Out_3, _Property_856E8F87_Out_0, _Clamp_33692D9C_Out_3, _Lerp_E29FCC84_Out_3);
                float _Lerp_8DBDB73C_Out_3;
                Unity_Lerp_float(_Lerp_6F531387_Out_3, _Lerp_E29FCC84_Out_3, _Split_42E433A0_G_2, _Lerp_8DBDB73C_Out_3);
                float _Lerp_8AAFCF3C_Out_3;
                Unity_Lerp_float(_Lerp_66D4299C_Out_3, _Property_DBC540D0_Out_0, _Clamp_142C06F9_Out_3, _Lerp_8AAFCF3C_Out_3);
                float _Lerp_994D7FFF_Out_3;
                Unity_Lerp_float(_Lerp_8DBDB73C_Out_3, _Lerp_8AAFCF3C_Out_3, _Split_42E433A0_B_3, _Lerp_994D7FFF_Out_3);
                float3 _Vector3_F416C92F_Out_0 = float3(_Lerp_994D7FFF_Out_3, _Lerp_994D7FFF_Out_3, _Lerp_994D7FFF_Out_3);
                float _Property_EE79CD0D_Out_0 = _WaterSmoothness;
                float _Property_643E836D_Out_0 = _FoamSmoothness;
                float _Lerp_554E8BA3_Out_3;
                Unity_Lerp_float(_Property_EE79CD0D_Out_0, _Property_643E836D_Out_0, _Multiply_6E6B7134_Out_2, _Lerp_554E8BA3_Out_3);
                float _Property_A47FA74D_Out_0 = _SmallCascadeSmoothness;
                float _Lerp_A0E087E1_Out_3;
                Unity_Lerp_float(_Lerp_554E8BA3_Out_3, _Property_A47FA74D_Out_0, _Lerp_8877E3D4_Out_3, _Lerp_A0E087E1_Out_3);
                float _Property_9C968D9C_Out_0 = _BigCascadeSmoothness;
                float _Lerp_FA93E461_Out_3;
                Unity_Lerp_float(_Lerp_A0E087E1_Out_3, _Property_9C968D9C_Out_0, _Lerp_6316FED8_Out_3, _Lerp_FA93E461_Out_3);
                float _Lerp_1FD1F935_Out_3;
                Unity_Lerp_float(_Lerp_FA93E461_Out_3, _Property_EE79CD0D_Out_0, _Split_42E433A0_R_1, _Lerp_1FD1F935_Out_3);
                float _Lerp_7F25D819_Out_3;
                Unity_Lerp_float(_Property_EE79CD0D_Out_0, _Property_A47FA74D_Out_0, _Clamp_33692D9C_Out_3, _Lerp_7F25D819_Out_3);
                float _Lerp_F3B8F35E_Out_3;
                Unity_Lerp_float(_Lerp_1FD1F935_Out_3, _Lerp_7F25D819_Out_3, _Split_42E433A0_G_2, _Lerp_F3B8F35E_Out_3);
                float _Lerp_5DE08151_Out_3;
                Unity_Lerp_float(_Property_EE79CD0D_Out_0, _Property_9C968D9C_Out_0, _Clamp_142C06F9_Out_3, _Lerp_5DE08151_Out_3);
                float _Lerp_A7696848_Out_3;
                Unity_Lerp_float(_Lerp_F3B8F35E_Out_3, _Lerp_5DE08151_Out_3, _Split_42E433A0_B_3, _Lerp_A7696848_Out_3);
                float _Property_A1F4E266_Out_0 = _AOPower;
                float _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                float _Property_44A9A39E_Out_0 = _EdgeFalloffMultiply;
                float _Multiply_943A3DD9_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_44A9A39E_Out_0, _Multiply_943A3DD9_Out_2);
                float _Clamp_16BD4100_Out_3;
                Unity_Clamp_float(_Multiply_943A3DD9_Out_2, 0, 1, _Clamp_16BD4100_Out_3);
                float _Absolute_1003CC59_Out_1;
                Unity_Absolute_float(_Clamp_16BD4100_Out_3, _Absolute_1003CC59_Out_1);
                float _Property_3A9F02A2_Out_0 = _EdgeFalloffPower;
                float _Power_54D889D2_Out_2;
                Unity_Power_float(_Absolute_1003CC59_Out_1, _Property_3A9F02A2_Out_0, _Power_54D889D2_Out_2);
                float _Clamp_A8945B73_Out_3;
                Unity_Clamp_float(_Power_54D889D2_Out_2, 0, 1, _Clamp_A8945B73_Out_3);
                float _Multiply_73E319C1_Out_2;
                Unity_Multiply_float(_Clamp_A8945B73_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                float _Property_6C82272C_Out_0 = _BackfaceAlpha;
                float _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_float(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                float _Branch_6D78BA69_Out_3;
                Unity_Branch_float(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                surface.Albedo = _Lerp_EE19DF0F_Out_3;
                surface.Normal = _Lerp_72DCEC20_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Specular = _Vector3_F416C92F_Out_0;
                surface.Smoothness = _Lerp_A7696848_Out_3;
                surface.Occlusion = _Property_A1F4E266_Out_0;
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv3 : TEXCOORD3;
                float4 color : COLOR;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS;
                float3 normalWS;
                float4 tangentWS;
                float4 texCoord0;
                float4 texCoord3;
                float4 color;
                float3 viewDirectionWS;
                #if defined(LIGHTMAP_ON)
                float2 lightmapUV;
                #endif
                #if !defined(LIGHTMAP_ON)
                float3 sh;
                #endif
                float4 fogFactorAndVertexLight;
                float4 shadowCoord;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if defined(LIGHTMAP_ON)
                #endif
                #if !defined(LIGHTMAP_ON)
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float3 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
                float4 interp03 : TEXCOORD3;
                float4 interp04 : TEXCOORD4;
                float4 interp05 : TEXCOORD5;
                float3 interp06 : TEXCOORD6;
                float2 interp07 : TEXCOORD7;
                float3 interp08 : TEXCOORD8;
                float4 interp09 : TEXCOORD9;
                float4 interp10 : TEXCOORD10;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord3;
                output.interp05.xyzw = input.color;
                output.interp06.xyz = input.viewDirectionWS;
                #if defined(LIGHTMAP_ON)
                output.interp07.xy = input.lightmapUV;
                #endif
                #if !defined(LIGHTMAP_ON)
                output.interp08.xyz = input.sh;
                #endif
                output.interp09.xyzw = input.fogFactorAndVertexLight;
                output.interp10.xyzw = input.shadowCoord;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord3 = input.interp04.xyzw;
                output.color = input.interp05.xyzw;
                output.viewDirectionWS = input.interp06.xyz;
                #if defined(LIGHTMAP_ON)
                output.lightmapUV = input.interp07.xy;
                #endif
                #if !defined(LIGHTMAP_ON)
                output.sh = input.interp08.xyz;
                #endif
                output.fogFactorAndVertexLight = input.interp09.xyzw;
                output.shadowCoord = input.interp10.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                output.uv0 =                         input.uv0;
                output.uv3 =                         input.uv3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            	float3 unnormalizedNormalWS = input.normalWS;
                const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            
            	// use bitangent on the fly like in hdrp
            	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
            	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
            
                output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            
            	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
            	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
            	output.WorldSpaceBiTangent =         renormFactor*bitang;
            
                output.WorldSpacePosition =          input.positionWS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                output.uv0 =                         input.texCoord0;
                output.uv3 =                         input.texCoord3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
                BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "ShadowCaster"
            Tags 
            { 
                "LightMode" = "ShadowCaster"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>
            
            // Defines
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define _NORMALMAP 1
            #define _SPECULAR_SETUP
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS 
            #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_SHADOWCASTER
            #define REQUIRE_DEPTH_TEXTURE
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float _GlobalTiling;
            float _UVVDirection1UDirection0;
            float2 _SlowWaterSpeed;
            float2 _SlowWaterMixSpeed;
            float2 _SmallCascadeMainSpeed;
            float2 _BigCascadeMainSpeed;
            float _EdgeFalloffMultiply;
            float _EdgeFalloffPower;
            float _CleanFalloffMultiply;
            float _CleanFalloffPower;
            float4 _ShalowColor;
            float _ShalowFalloffMultiply;
            float _ShalowFalloffPower;
            float4 _DeepColor;
            float _WaterAlphaMultiply;
            float _WaterAlphaPower;
            float _WaveTranslucencyFallOffDistance;
            float _WaveTranslucencyPower;
            float _WaveTranslucencyHardness;
            float _WaveTranslucencyMultiply;
            float _SlowWaterTranslucencyMultiply;
            float _SmallCascadeTranslucencyMultiply;
            float _BigCascadeTranslucencyMultiply;
            float _WaterSmoothness;
            float _WaterSpecularClose;
            float _WaterSpecularFar;
            float _WaterSpecularThreshold;
            float _Distortion;
            float _BackfaceAlpha;
            float _MicroWaveNormalScale;
            float2 _MicroWaveTiling;
            float _MacroWaveNormalScale;
            float2 _MacroWaveTiling;
            float2 _SlowWaterTiling;
            float _SlowNormalScale;
            float _FarNormalPower;
            float _FarNormalBlendStartDistance;
            float _FarNormalBlendThreshold;
            float _SmallCascadeAngle;
            float _SmallCascadeAngleFalloff;
            float2 _SmallCascadeTiling;
            float _SmallCascadeNormalScale;
            float3 _SmallCascadeColor;
            float _SmallCascadeFoamFalloff;
            float _SmallCascadeSmoothness;
            float _SmallCascadeSpecular;
            float _BigCascadeAngle;
            float _BigCascadeAngleFalloff;
            float _BigCascadeNormalScale;
            float2 _BigCascadeTiling;
            float3 _BigCascadeColor;
            float Big_Cascade_Foam_Falloff;
            float _BigCascadeTransparency;
            float _BigCascadeSmoothness;
            float _BigCascadeSpecular;
            float _SlowWaterTessScale;
            float MacroWaveTessScale;
            float _SmallCascadeWaterTessScale;
            float _BigCascadeWaterTessScale;
            float _SmallCascadeNoisePower;
            float _BigCascadeNoisePower;
            float _SmallCascadeNoiseMultiply;
            float _BigCascadeNoiseMultiply;
            float2 _FoamTiling;
            float2 _FoamSpeed;
            float3 _FoamColor;
            float _FoamDepth;
            float _FoamFalloff;
            float _FoamWaveHardness;
            float _FoamWavePower;
            float _FoamWaveMultiply;
            float _FoamSmoothness;
            float _FoamSpecular;
            float2 _NoiseTiling;
            float2 _NoiseSpeed;
            float _AOPower;
            float _WaterFlowUVRefresSpeed;
            float _SmallCascadeFlowUVRefreshSpeed;
            float _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); float4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_SmallCascadeNormal); SAMPLER(sampler_SmallCascadeNormal); float4 _SmallCascadeNormal_TexelSize;
            TEXTURE2D(_SmallCascade); SAMPLER(sampler_SmallCascade); float4 _SmallCascade_TexelSize;
            TEXTURE2D(_BigCascadeNormal); SAMPLER(sampler_BigCascadeNormal); float4 _BigCascadeNormal_TexelSize;
            TEXTURE2D(_BigCascade); SAMPLER(sampler_BigCascade); float4 _BigCascade_TexelSize;
            TEXTURE2D(_SlowWaterTesselation); SAMPLER(sampler_SlowWaterTesselation); float4 _SlowWaterTesselation_TexelSize;
            TEXTURE2D(_SmallCascadeWaterTess); SAMPLER(sampler_SmallCascadeWaterTess); float4 _SmallCascadeWaterTess_TexelSize;
            TEXTURE2D(BigCascadeWaterTess); SAMPLER(samplerBigCascadeWaterTess); float4 BigCascadeWaterTess_TexelSize;
            TEXTURE2D(_Foam); SAMPLER(sampler_Foam); float4 _Foam_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); float4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2DLOD_35997DE_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F6D4A02B_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_CABCD0D0_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_2BB41D12_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F0E303B2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_27B55B65_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_4648E9_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Fraction_float(float In, out float Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float4 _SampleTexture2DLOD_35997DE_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_4ECADB09_Out_2, 0);
                float _SampleTexture2DLOD_35997DE_R_5 = _SampleTexture2DLOD_35997DE_RGBA_0.r;
                float _SampleTexture2DLOD_35997DE_G_6 = _SampleTexture2DLOD_35997DE_RGBA_0.g;
                float _SampleTexture2DLOD_35997DE_B_7 = _SampleTexture2DLOD_35997DE_RGBA_0.b;
                float _SampleTexture2DLOD_35997DE_A_8 = _SampleTexture2DLOD_35997DE_RGBA_0.a;
                float _Add_92BD554B_Out_2;
                Unity_Add_float(_SampleTexture2DLOD_35997DE_A_8, -0.25, _Add_92BD554B_Out_2);
                float _Property_6AEE6AD6_Out_0 = MacroWaveTessScale;
                float _Multiply_B04BDAD0_Out_2;
                Unity_Multiply_float(_Add_92BD554B_Out_2, _Property_6AEE6AD6_Out_0, _Multiply_B04BDAD0_Out_2);
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_FE512398_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_FE512398_Out_2);
                float4 _SampleTexture2DLOD_F6D4A02B_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_FE512398_Out_2, 0);
                float _SampleTexture2DLOD_F6D4A02B_R_5 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.r;
                float _SampleTexture2DLOD_F6D4A02B_G_6 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.g;
                float _SampleTexture2DLOD_F6D4A02B_B_7 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.b;
                float _SampleTexture2DLOD_F6D4A02B_A_8 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.a;
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_3D189493_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_3D189493_Out_2);
                float4 _SampleTexture2DLOD_CABCD0D0_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_3D189493_Out_2, 0);
                float _SampleTexture2DLOD_CABCD0D0_R_5 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.r;
                float _SampleTexture2DLOD_CABCD0D0_G_6 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.g;
                float _SampleTexture2DLOD_CABCD0D0_B_7 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.b;
                float _SampleTexture2DLOD_CABCD0D0_A_8 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.a;
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_B4922E7C_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_B4922E7C_Out_1);
                float _Lerp_DEF9BA7B_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_F6D4A02B_A_8, _SampleTexture2DLOD_CABCD0D0_A_8, _Absolute_B4922E7C_Out_1, _Lerp_DEF9BA7B_Out_3);
                float _Add_E7355D81_Out_2;
                Unity_Add_float(_Lerp_DEF9BA7B_Out_3, -0.25, _Add_E7355D81_Out_2);
                float _Property_57308837_Out_0 = _SlowWaterTessScale;
                float _Multiply_146A3378_Out_2;
                Unity_Multiply_float(_Add_E7355D81_Out_2, _Property_57308837_Out_0, _Multiply_146A3378_Out_2);
                float _Add_42AED159_Out_2;
                Unity_Add_float(_Multiply_B04BDAD0_Out_2, _Multiply_146A3378_Out_2, _Add_42AED159_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_C675255A_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_C675255A_Out_2);
                float4 _SampleTexture2DLOD_2BB41D12_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_C675255A_Out_2, 0);
                float _SampleTexture2DLOD_2BB41D12_R_5 = _SampleTexture2DLOD_2BB41D12_RGBA_0.r;
                float _SampleTexture2DLOD_2BB41D12_G_6 = _SampleTexture2DLOD_2BB41D12_RGBA_0.g;
                float _SampleTexture2DLOD_2BB41D12_B_7 = _SampleTexture2DLOD_2BB41D12_RGBA_0.b;
                float _SampleTexture2DLOD_2BB41D12_A_8 = _SampleTexture2DLOD_2BB41D12_RGBA_0.a;
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_89DE95D0_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_89DE95D0_Out_2);
                float4 _SampleTexture2DLOD_F0E303B2_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_89DE95D0_Out_2, 0);
                float _SampleTexture2DLOD_F0E303B2_R_5 = _SampleTexture2DLOD_F0E303B2_RGBA_0.r;
                float _SampleTexture2DLOD_F0E303B2_G_6 = _SampleTexture2DLOD_F0E303B2_RGBA_0.g;
                float _SampleTexture2DLOD_F0E303B2_B_7 = _SampleTexture2DLOD_F0E303B2_RGBA_0.b;
                float _SampleTexture2DLOD_F0E303B2_A_8 = _SampleTexture2DLOD_F0E303B2_RGBA_0.a;
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float _Lerp_4F958902_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_2BB41D12_A_8, _SampleTexture2DLOD_F0E303B2_A_8, _Absolute_D56AD49D_Out_1, _Lerp_4F958902_Out_3);
                float _Add_4C244952_Out_2;
                Unity_Add_float(_Lerp_4F958902_Out_3, -0.25, _Add_4C244952_Out_2);
                float _Property_A41EED02_Out_0 = _SmallCascadeWaterTessScale;
                float _Multiply_C6FA813B_Out_2;
                Unity_Multiply_float(_Add_4C244952_Out_2, _Property_A41EED02_Out_0, _Multiply_C6FA813B_Out_2);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float _Multiply_97C7958D_Out_2;
                Unity_Multiply_float(_Multiply_C6FA813B_Out_2, _Clamp_C9BB189_Out_3, _Multiply_97C7958D_Out_2);
                float _Add_B8D97A66_Out_2;
                Unity_Add_float(_Add_42AED159_Out_2, _Multiply_97C7958D_Out_2, _Add_B8D97A66_Out_2);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_260C289D_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_260C289D_Out_2);
                float4 _SampleTexture2DLOD_27B55B65_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_260C289D_Out_2, 0);
                float _SampleTexture2DLOD_27B55B65_R_5 = _SampleTexture2DLOD_27B55B65_RGBA_0.r;
                float _SampleTexture2DLOD_27B55B65_G_6 = _SampleTexture2DLOD_27B55B65_RGBA_0.g;
                float _SampleTexture2DLOD_27B55B65_B_7 = _SampleTexture2DLOD_27B55B65_RGBA_0.b;
                float _SampleTexture2DLOD_27B55B65_A_8 = _SampleTexture2DLOD_27B55B65_RGBA_0.a;
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_672C60ED_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_672C60ED_Out_2);
                float4 _SampleTexture2DLOD_4648E9_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_672C60ED_Out_2, 0);
                float _SampleTexture2DLOD_4648E9_R_5 = _SampleTexture2DLOD_4648E9_RGBA_0.r;
                float _SampleTexture2DLOD_4648E9_G_6 = _SampleTexture2DLOD_4648E9_RGBA_0.g;
                float _SampleTexture2DLOD_4648E9_B_7 = _SampleTexture2DLOD_4648E9_RGBA_0.b;
                float _SampleTexture2DLOD_4648E9_A_8 = _SampleTexture2DLOD_4648E9_RGBA_0.a;
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Lerp_1934036C_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_27B55B65_A_8, _SampleTexture2DLOD_4648E9_A_8, _Absolute_19D4C5A5_Out_1, _Lerp_1934036C_Out_3);
                float _Add_5F941B40_Out_2;
                Unity_Add_float(_Lerp_1934036C_Out_3, -0.25, _Add_5F941B40_Out_2);
                float _Property_D14DBA62_Out_0 = _BigCascadeWaterTessScale;
                float _Multiply_131F4390_Out_2;
                Unity_Multiply_float(_Add_5F941B40_Out_2, _Property_D14DBA62_Out_0, _Multiply_131F4390_Out_2);
                float _Multiply_F5B5CD1C_Out_2;
                Unity_Multiply_float(_Multiply_131F4390_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_F5B5CD1C_Out_2);
                float _Add_2878DA0E_Out_2;
                Unity_Add_float(_Add_B8D97A66_Out_2, _Multiply_F5B5CD1C_Out_2, _Add_2878DA0E_Out_2);
                float _Split_28662C1C_R_1 = IN.VertexColor[0];
                float _Split_28662C1C_G_2 = IN.VertexColor[1];
                float _Split_28662C1C_B_3 = IN.VertexColor[2];
                float _Split_28662C1C_A_4 = IN.VertexColor[3];
                float _Lerp_A69B24EB_Out_3;
                Unity_Lerp_float(_Add_2878DA0E_Out_2, _Add_42AED159_Out_2, _Split_28662C1C_R_1, _Lerp_A69B24EB_Out_3);
                float _Lerp_B24A0C56_Out_3;
                Unity_Lerp_float(_Lerp_A69B24EB_Out_3, _Multiply_97C7958D_Out_2, _Split_28662C1C_G_2, _Lerp_B24A0C56_Out_3);
                float _Lerp_5C765D8_Out_3;
                Unity_Lerp_float(_Lerp_B24A0C56_Out_3, _Multiply_131F4390_Out_2, _Split_28662C1C_B_3, _Lerp_5C765D8_Out_3);
                float3 _Multiply_238083B9_Out_2;
                Unity_Multiply_float(IN.ObjectSpaceNormal, (_Lerp_5C765D8_Out_3.xxx), _Multiply_238083B9_Out_2);
                float3 _Add_8A04BBE9_Out_2;
                Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_238083B9_Out_2, _Add_8A04BBE9_Out_2);
                description.VertexPosition = _Add_8A04BBE9_Out_2;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float3 WorldSpacePosition;
                float4 ScreenPosition;
                float4 VertexColor;
                float FaceSign;
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                float4 _ScreenPosition_E4782AF8_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_float(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                float _Multiply_39A1673A_Out_2;
                Unity_Multiply_float(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                float4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                float _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                float _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                float _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                float _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                float _Subtract_331D19CE_Out_2;
                Unity_Subtract_float(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                float _Property_44A9A39E_Out_0 = _EdgeFalloffMultiply;
                float _Multiply_943A3DD9_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_44A9A39E_Out_0, _Multiply_943A3DD9_Out_2);
                float _Clamp_16BD4100_Out_3;
                Unity_Clamp_float(_Multiply_943A3DD9_Out_2, 0, 1, _Clamp_16BD4100_Out_3);
                float _Absolute_1003CC59_Out_1;
                Unity_Absolute_float(_Clamp_16BD4100_Out_3, _Absolute_1003CC59_Out_1);
                float _Property_3A9F02A2_Out_0 = _EdgeFalloffPower;
                float _Power_54D889D2_Out_2;
                Unity_Power_float(_Absolute_1003CC59_Out_1, _Property_3A9F02A2_Out_0, _Power_54D889D2_Out_2);
                float _Clamp_A8945B73_Out_3;
                Unity_Clamp_float(_Power_54D889D2_Out_2, 0, 1, _Clamp_A8945B73_Out_3);
                float _Split_42E433A0_R_1 = IN.VertexColor[0];
                float _Split_42E433A0_G_2 = IN.VertexColor[1];
                float _Split_42E433A0_B_3 = IN.VertexColor[2];
                float _Split_42E433A0_A_4 = IN.VertexColor[3];
                float _Multiply_73E319C1_Out_2;
                Unity_Multiply_float(_Clamp_A8945B73_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                float _Property_6C82272C_Out_0 = _BackfaceAlpha;
                float _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_float(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                float _Branch_6D78BA69_Out_3;
                Unity_Branch_float(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 uv3 : TEXCOORD3;
                float4 color : COLOR;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS;
                float4 color;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float4 interp01 : TEXCOORD1;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.color = input.interp01.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                output.uv0 =                         input.uv0;
                output.uv3 =                         input.uv3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
                output.WorldSpacePosition =          input.positionWS;
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                output.VertexColor =                 input.color;
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
                BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "DepthOnly"
            Tags 
            { 
                "LightMode" = "DepthOnly"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            ColorMask 0
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>
            
            // Defines
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define _NORMALMAP 1
            #define _SPECULAR_SETUP
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS 
            #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_DEPTHONLY
            #define REQUIRE_DEPTH_TEXTURE
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float _GlobalTiling;
            float _UVVDirection1UDirection0;
            float2 _SlowWaterSpeed;
            float2 _SlowWaterMixSpeed;
            float2 _SmallCascadeMainSpeed;
            float2 _BigCascadeMainSpeed;
            float _EdgeFalloffMultiply;
            float _EdgeFalloffPower;
            float _CleanFalloffMultiply;
            float _CleanFalloffPower;
            float4 _ShalowColor;
            float _ShalowFalloffMultiply;
            float _ShalowFalloffPower;
            float4 _DeepColor;
            float _WaterAlphaMultiply;
            float _WaterAlphaPower;
            float _WaveTranslucencyFallOffDistance;
            float _WaveTranslucencyPower;
            float _WaveTranslucencyHardness;
            float _WaveTranslucencyMultiply;
            float _SlowWaterTranslucencyMultiply;
            float _SmallCascadeTranslucencyMultiply;
            float _BigCascadeTranslucencyMultiply;
            float _WaterSmoothness;
            float _WaterSpecularClose;
            float _WaterSpecularFar;
            float _WaterSpecularThreshold;
            float _Distortion;
            float _BackfaceAlpha;
            float _MicroWaveNormalScale;
            float2 _MicroWaveTiling;
            float _MacroWaveNormalScale;
            float2 _MacroWaveTiling;
            float2 _SlowWaterTiling;
            float _SlowNormalScale;
            float _FarNormalPower;
            float _FarNormalBlendStartDistance;
            float _FarNormalBlendThreshold;
            float _SmallCascadeAngle;
            float _SmallCascadeAngleFalloff;
            float2 _SmallCascadeTiling;
            float _SmallCascadeNormalScale;
            float3 _SmallCascadeColor;
            float _SmallCascadeFoamFalloff;
            float _SmallCascadeSmoothness;
            float _SmallCascadeSpecular;
            float _BigCascadeAngle;
            float _BigCascadeAngleFalloff;
            float _BigCascadeNormalScale;
            float2 _BigCascadeTiling;
            float3 _BigCascadeColor;
            float Big_Cascade_Foam_Falloff;
            float _BigCascadeTransparency;
            float _BigCascadeSmoothness;
            float _BigCascadeSpecular;
            float _SlowWaterTessScale;
            float MacroWaveTessScale;
            float _SmallCascadeWaterTessScale;
            float _BigCascadeWaterTessScale;
            float _SmallCascadeNoisePower;
            float _BigCascadeNoisePower;
            float _SmallCascadeNoiseMultiply;
            float _BigCascadeNoiseMultiply;
            float2 _FoamTiling;
            float2 _FoamSpeed;
            float3 _FoamColor;
            float _FoamDepth;
            float _FoamFalloff;
            float _FoamWaveHardness;
            float _FoamWavePower;
            float _FoamWaveMultiply;
            float _FoamSmoothness;
            float _FoamSpecular;
            float2 _NoiseTiling;
            float2 _NoiseSpeed;
            float _AOPower;
            float _WaterFlowUVRefresSpeed;
            float _SmallCascadeFlowUVRefreshSpeed;
            float _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); float4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_SmallCascadeNormal); SAMPLER(sampler_SmallCascadeNormal); float4 _SmallCascadeNormal_TexelSize;
            TEXTURE2D(_SmallCascade); SAMPLER(sampler_SmallCascade); float4 _SmallCascade_TexelSize;
            TEXTURE2D(_BigCascadeNormal); SAMPLER(sampler_BigCascadeNormal); float4 _BigCascadeNormal_TexelSize;
            TEXTURE2D(_BigCascade); SAMPLER(sampler_BigCascade); float4 _BigCascade_TexelSize;
            TEXTURE2D(_SlowWaterTesselation); SAMPLER(sampler_SlowWaterTesselation); float4 _SlowWaterTesselation_TexelSize;
            TEXTURE2D(_SmallCascadeWaterTess); SAMPLER(sampler_SmallCascadeWaterTess); float4 _SmallCascadeWaterTess_TexelSize;
            TEXTURE2D(BigCascadeWaterTess); SAMPLER(samplerBigCascadeWaterTess); float4 BigCascadeWaterTess_TexelSize;
            TEXTURE2D(_Foam); SAMPLER(sampler_Foam); float4 _Foam_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); float4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2DLOD_35997DE_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F6D4A02B_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_CABCD0D0_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_2BB41D12_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F0E303B2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_27B55B65_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_4648E9_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Fraction_float(float In, out float Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float4 _SampleTexture2DLOD_35997DE_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_4ECADB09_Out_2, 0);
                float _SampleTexture2DLOD_35997DE_R_5 = _SampleTexture2DLOD_35997DE_RGBA_0.r;
                float _SampleTexture2DLOD_35997DE_G_6 = _SampleTexture2DLOD_35997DE_RGBA_0.g;
                float _SampleTexture2DLOD_35997DE_B_7 = _SampleTexture2DLOD_35997DE_RGBA_0.b;
                float _SampleTexture2DLOD_35997DE_A_8 = _SampleTexture2DLOD_35997DE_RGBA_0.a;
                float _Add_92BD554B_Out_2;
                Unity_Add_float(_SampleTexture2DLOD_35997DE_A_8, -0.25, _Add_92BD554B_Out_2);
                float _Property_6AEE6AD6_Out_0 = MacroWaveTessScale;
                float _Multiply_B04BDAD0_Out_2;
                Unity_Multiply_float(_Add_92BD554B_Out_2, _Property_6AEE6AD6_Out_0, _Multiply_B04BDAD0_Out_2);
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_FE512398_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_FE512398_Out_2);
                float4 _SampleTexture2DLOD_F6D4A02B_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_FE512398_Out_2, 0);
                float _SampleTexture2DLOD_F6D4A02B_R_5 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.r;
                float _SampleTexture2DLOD_F6D4A02B_G_6 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.g;
                float _SampleTexture2DLOD_F6D4A02B_B_7 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.b;
                float _SampleTexture2DLOD_F6D4A02B_A_8 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.a;
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_3D189493_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_3D189493_Out_2);
                float4 _SampleTexture2DLOD_CABCD0D0_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_3D189493_Out_2, 0);
                float _SampleTexture2DLOD_CABCD0D0_R_5 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.r;
                float _SampleTexture2DLOD_CABCD0D0_G_6 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.g;
                float _SampleTexture2DLOD_CABCD0D0_B_7 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.b;
                float _SampleTexture2DLOD_CABCD0D0_A_8 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.a;
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_B4922E7C_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_B4922E7C_Out_1);
                float _Lerp_DEF9BA7B_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_F6D4A02B_A_8, _SampleTexture2DLOD_CABCD0D0_A_8, _Absolute_B4922E7C_Out_1, _Lerp_DEF9BA7B_Out_3);
                float _Add_E7355D81_Out_2;
                Unity_Add_float(_Lerp_DEF9BA7B_Out_3, -0.25, _Add_E7355D81_Out_2);
                float _Property_57308837_Out_0 = _SlowWaterTessScale;
                float _Multiply_146A3378_Out_2;
                Unity_Multiply_float(_Add_E7355D81_Out_2, _Property_57308837_Out_0, _Multiply_146A3378_Out_2);
                float _Add_42AED159_Out_2;
                Unity_Add_float(_Multiply_B04BDAD0_Out_2, _Multiply_146A3378_Out_2, _Add_42AED159_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_C675255A_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_C675255A_Out_2);
                float4 _SampleTexture2DLOD_2BB41D12_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_C675255A_Out_2, 0);
                float _SampleTexture2DLOD_2BB41D12_R_5 = _SampleTexture2DLOD_2BB41D12_RGBA_0.r;
                float _SampleTexture2DLOD_2BB41D12_G_6 = _SampleTexture2DLOD_2BB41D12_RGBA_0.g;
                float _SampleTexture2DLOD_2BB41D12_B_7 = _SampleTexture2DLOD_2BB41D12_RGBA_0.b;
                float _SampleTexture2DLOD_2BB41D12_A_8 = _SampleTexture2DLOD_2BB41D12_RGBA_0.a;
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_89DE95D0_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_89DE95D0_Out_2);
                float4 _SampleTexture2DLOD_F0E303B2_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_89DE95D0_Out_2, 0);
                float _SampleTexture2DLOD_F0E303B2_R_5 = _SampleTexture2DLOD_F0E303B2_RGBA_0.r;
                float _SampleTexture2DLOD_F0E303B2_G_6 = _SampleTexture2DLOD_F0E303B2_RGBA_0.g;
                float _SampleTexture2DLOD_F0E303B2_B_7 = _SampleTexture2DLOD_F0E303B2_RGBA_0.b;
                float _SampleTexture2DLOD_F0E303B2_A_8 = _SampleTexture2DLOD_F0E303B2_RGBA_0.a;
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float _Lerp_4F958902_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_2BB41D12_A_8, _SampleTexture2DLOD_F0E303B2_A_8, _Absolute_D56AD49D_Out_1, _Lerp_4F958902_Out_3);
                float _Add_4C244952_Out_2;
                Unity_Add_float(_Lerp_4F958902_Out_3, -0.25, _Add_4C244952_Out_2);
                float _Property_A41EED02_Out_0 = _SmallCascadeWaterTessScale;
                float _Multiply_C6FA813B_Out_2;
                Unity_Multiply_float(_Add_4C244952_Out_2, _Property_A41EED02_Out_0, _Multiply_C6FA813B_Out_2);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float _Multiply_97C7958D_Out_2;
                Unity_Multiply_float(_Multiply_C6FA813B_Out_2, _Clamp_C9BB189_Out_3, _Multiply_97C7958D_Out_2);
                float _Add_B8D97A66_Out_2;
                Unity_Add_float(_Add_42AED159_Out_2, _Multiply_97C7958D_Out_2, _Add_B8D97A66_Out_2);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_260C289D_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_260C289D_Out_2);
                float4 _SampleTexture2DLOD_27B55B65_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_260C289D_Out_2, 0);
                float _SampleTexture2DLOD_27B55B65_R_5 = _SampleTexture2DLOD_27B55B65_RGBA_0.r;
                float _SampleTexture2DLOD_27B55B65_G_6 = _SampleTexture2DLOD_27B55B65_RGBA_0.g;
                float _SampleTexture2DLOD_27B55B65_B_7 = _SampleTexture2DLOD_27B55B65_RGBA_0.b;
                float _SampleTexture2DLOD_27B55B65_A_8 = _SampleTexture2DLOD_27B55B65_RGBA_0.a;
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_672C60ED_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_672C60ED_Out_2);
                float4 _SampleTexture2DLOD_4648E9_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_672C60ED_Out_2, 0);
                float _SampleTexture2DLOD_4648E9_R_5 = _SampleTexture2DLOD_4648E9_RGBA_0.r;
                float _SampleTexture2DLOD_4648E9_G_6 = _SampleTexture2DLOD_4648E9_RGBA_0.g;
                float _SampleTexture2DLOD_4648E9_B_7 = _SampleTexture2DLOD_4648E9_RGBA_0.b;
                float _SampleTexture2DLOD_4648E9_A_8 = _SampleTexture2DLOD_4648E9_RGBA_0.a;
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Lerp_1934036C_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_27B55B65_A_8, _SampleTexture2DLOD_4648E9_A_8, _Absolute_19D4C5A5_Out_1, _Lerp_1934036C_Out_3);
                float _Add_5F941B40_Out_2;
                Unity_Add_float(_Lerp_1934036C_Out_3, -0.25, _Add_5F941B40_Out_2);
                float _Property_D14DBA62_Out_0 = _BigCascadeWaterTessScale;
                float _Multiply_131F4390_Out_2;
                Unity_Multiply_float(_Add_5F941B40_Out_2, _Property_D14DBA62_Out_0, _Multiply_131F4390_Out_2);
                float _Multiply_F5B5CD1C_Out_2;
                Unity_Multiply_float(_Multiply_131F4390_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_F5B5CD1C_Out_2);
                float _Add_2878DA0E_Out_2;
                Unity_Add_float(_Add_B8D97A66_Out_2, _Multiply_F5B5CD1C_Out_2, _Add_2878DA0E_Out_2);
                float _Split_28662C1C_R_1 = IN.VertexColor[0];
                float _Split_28662C1C_G_2 = IN.VertexColor[1];
                float _Split_28662C1C_B_3 = IN.VertexColor[2];
                float _Split_28662C1C_A_4 = IN.VertexColor[3];
                float _Lerp_A69B24EB_Out_3;
                Unity_Lerp_float(_Add_2878DA0E_Out_2, _Add_42AED159_Out_2, _Split_28662C1C_R_1, _Lerp_A69B24EB_Out_3);
                float _Lerp_B24A0C56_Out_3;
                Unity_Lerp_float(_Lerp_A69B24EB_Out_3, _Multiply_97C7958D_Out_2, _Split_28662C1C_G_2, _Lerp_B24A0C56_Out_3);
                float _Lerp_5C765D8_Out_3;
                Unity_Lerp_float(_Lerp_B24A0C56_Out_3, _Multiply_131F4390_Out_2, _Split_28662C1C_B_3, _Lerp_5C765D8_Out_3);
                float3 _Multiply_238083B9_Out_2;
                Unity_Multiply_float(IN.ObjectSpaceNormal, (_Lerp_5C765D8_Out_3.xxx), _Multiply_238083B9_Out_2);
                float3 _Add_8A04BBE9_Out_2;
                Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_238083B9_Out_2, _Add_8A04BBE9_Out_2);
                description.VertexPosition = _Add_8A04BBE9_Out_2;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float3 WorldSpacePosition;
                float4 ScreenPosition;
                float4 VertexColor;
                float FaceSign;
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                float4 _ScreenPosition_E4782AF8_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_float(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                float _Multiply_39A1673A_Out_2;
                Unity_Multiply_float(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                float4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                float _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                float _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                float _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                float _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                float _Subtract_331D19CE_Out_2;
                Unity_Subtract_float(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                float _Property_44A9A39E_Out_0 = _EdgeFalloffMultiply;
                float _Multiply_943A3DD9_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_44A9A39E_Out_0, _Multiply_943A3DD9_Out_2);
                float _Clamp_16BD4100_Out_3;
                Unity_Clamp_float(_Multiply_943A3DD9_Out_2, 0, 1, _Clamp_16BD4100_Out_3);
                float _Absolute_1003CC59_Out_1;
                Unity_Absolute_float(_Clamp_16BD4100_Out_3, _Absolute_1003CC59_Out_1);
                float _Property_3A9F02A2_Out_0 = _EdgeFalloffPower;
                float _Power_54D889D2_Out_2;
                Unity_Power_float(_Absolute_1003CC59_Out_1, _Property_3A9F02A2_Out_0, _Power_54D889D2_Out_2);
                float _Clamp_A8945B73_Out_3;
                Unity_Clamp_float(_Power_54D889D2_Out_2, 0, 1, _Clamp_A8945B73_Out_3);
                float _Split_42E433A0_R_1 = IN.VertexColor[0];
                float _Split_42E433A0_G_2 = IN.VertexColor[1];
                float _Split_42E433A0_B_3 = IN.VertexColor[2];
                float _Split_42E433A0_A_4 = IN.VertexColor[3];
                float _Multiply_73E319C1_Out_2;
                Unity_Multiply_float(_Clamp_A8945B73_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                float _Property_6C82272C_Out_0 = _BackfaceAlpha;
                float _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_float(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                float _Branch_6D78BA69_Out_3;
                Unity_Branch_float(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 uv3 : TEXCOORD3;
                float4 color : COLOR;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS;
                float4 color;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float4 interp01 : TEXCOORD1;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.color = input.interp01.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                output.uv0 =                         input.uv0;
                output.uv3 =                         input.uv3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
                output.WorldSpacePosition =          input.positionWS;
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                output.VertexColor =                 input.color;
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
                BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "Meta"
            Tags 
            { 
                "LightMode" = "Meta"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
        
            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            // GraphKeywords: <None>
            
            // Defines
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define _NORMALMAP 1
            #define _SPECULAR_SETUP
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS 
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_META
            #define REQUIRE_DEPTH_TEXTURE
            #define REQUIRE_OPAQUE_TEXTURE
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float _GlobalTiling;
            float _UVVDirection1UDirection0;
            float2 _SlowWaterSpeed;
            float2 _SlowWaterMixSpeed;
            float2 _SmallCascadeMainSpeed;
            float2 _BigCascadeMainSpeed;
            float _EdgeFalloffMultiply;
            float _EdgeFalloffPower;
            float _CleanFalloffMultiply;
            float _CleanFalloffPower;
            float4 _ShalowColor;
            float _ShalowFalloffMultiply;
            float _ShalowFalloffPower;
            float4 _DeepColor;
            float _WaterAlphaMultiply;
            float _WaterAlphaPower;
            float _WaveTranslucencyFallOffDistance;
            float _WaveTranslucencyPower;
            float _WaveTranslucencyHardness;
            float _WaveTranslucencyMultiply;
            float _SlowWaterTranslucencyMultiply;
            float _SmallCascadeTranslucencyMultiply;
            float _BigCascadeTranslucencyMultiply;
            float _WaterSmoothness;
            float _WaterSpecularClose;
            float _WaterSpecularFar;
            float _WaterSpecularThreshold;
            float _Distortion;
            float _BackfaceAlpha;
            float _MicroWaveNormalScale;
            float2 _MicroWaveTiling;
            float _MacroWaveNormalScale;
            float2 _MacroWaveTiling;
            float2 _SlowWaterTiling;
            float _SlowNormalScale;
            float _FarNormalPower;
            float _FarNormalBlendStartDistance;
            float _FarNormalBlendThreshold;
            float _SmallCascadeAngle;
            float _SmallCascadeAngleFalloff;
            float2 _SmallCascadeTiling;
            float _SmallCascadeNormalScale;
            float3 _SmallCascadeColor;
            float _SmallCascadeFoamFalloff;
            float _SmallCascadeSmoothness;
            float _SmallCascadeSpecular;
            float _BigCascadeAngle;
            float _BigCascadeAngleFalloff;
            float _BigCascadeNormalScale;
            float2 _BigCascadeTiling;
            float3 _BigCascadeColor;
            float Big_Cascade_Foam_Falloff;
            float _BigCascadeTransparency;
            float _BigCascadeSmoothness;
            float _BigCascadeSpecular;
            float _SlowWaterTessScale;
            float MacroWaveTessScale;
            float _SmallCascadeWaterTessScale;
            float _BigCascadeWaterTessScale;
            float _SmallCascadeNoisePower;
            float _BigCascadeNoisePower;
            float _SmallCascadeNoiseMultiply;
            float _BigCascadeNoiseMultiply;
            float2 _FoamTiling;
            float2 _FoamSpeed;
            float3 _FoamColor;
            float _FoamDepth;
            float _FoamFalloff;
            float _FoamWaveHardness;
            float _FoamWavePower;
            float _FoamWaveMultiply;
            float _FoamSmoothness;
            float _FoamSpecular;
            float2 _NoiseTiling;
            float2 _NoiseSpeed;
            float _AOPower;
            float _WaterFlowUVRefresSpeed;
            float _SmallCascadeFlowUVRefreshSpeed;
            float _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); float4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_SmallCascadeNormal); SAMPLER(sampler_SmallCascadeNormal); float4 _SmallCascadeNormal_TexelSize;
            TEXTURE2D(_SmallCascade); SAMPLER(sampler_SmallCascade); float4 _SmallCascade_TexelSize;
            TEXTURE2D(_BigCascadeNormal); SAMPLER(sampler_BigCascadeNormal); float4 _BigCascadeNormal_TexelSize;
            TEXTURE2D(_BigCascade); SAMPLER(sampler_BigCascade); float4 _BigCascade_TexelSize;
            TEXTURE2D(_SlowWaterTesselation); SAMPLER(sampler_SlowWaterTesselation); float4 _SlowWaterTesselation_TexelSize;
            TEXTURE2D(_SmallCascadeWaterTess); SAMPLER(sampler_SmallCascadeWaterTess); float4 _SmallCascadeWaterTess_TexelSize;
            TEXTURE2D(BigCascadeWaterTess); SAMPLER(samplerBigCascadeWaterTess); float4 BigCascadeWaterTess_TexelSize;
            TEXTURE2D(_Foam); SAMPLER(sampler_Foam); float4 _Foam_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); float4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2DLOD_35997DE_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F6D4A02B_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_CABCD0D0_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_2BB41D12_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F0E303B2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_27B55B65_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_4648E9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_F765A3FA_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_49A71497_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6ABE710E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6FC3A421_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_13F501DC_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_C713F57F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_5CD91024_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_28CB720F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_8FF1FC6F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_3D04E744_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_FDC3D2E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D6FF940D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_80481243_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D803AB07_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_198CC76A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_387AEB22_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9FEF114B_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Fraction_float(float In, out float Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
            {
                Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_ChannelMask_RedGreen_float3 (float3 In, out float3 Out)
            {
                Out = float3(In.r, In.g, 0);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Normalize_float3(float3 In, out float3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Distance_float3(float3 A, float3 B, out float Out)
            {
                Out = distance(A, B);
            }
            
            void Unity_SceneColor_float(float4 UV, out float3 Out)
            {
                Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
            }
            
            void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Blend_Overwrite_float(float Base, float Blend, out float Out, float Opacity)
            {
                Out = lerp(Base, Blend, Opacity);
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float4 _SampleTexture2DLOD_35997DE_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_4ECADB09_Out_2, 0);
                float _SampleTexture2DLOD_35997DE_R_5 = _SampleTexture2DLOD_35997DE_RGBA_0.r;
                float _SampleTexture2DLOD_35997DE_G_6 = _SampleTexture2DLOD_35997DE_RGBA_0.g;
                float _SampleTexture2DLOD_35997DE_B_7 = _SampleTexture2DLOD_35997DE_RGBA_0.b;
                float _SampleTexture2DLOD_35997DE_A_8 = _SampleTexture2DLOD_35997DE_RGBA_0.a;
                float _Add_92BD554B_Out_2;
                Unity_Add_float(_SampleTexture2DLOD_35997DE_A_8, -0.25, _Add_92BD554B_Out_2);
                float _Property_6AEE6AD6_Out_0 = MacroWaveTessScale;
                float _Multiply_B04BDAD0_Out_2;
                Unity_Multiply_float(_Add_92BD554B_Out_2, _Property_6AEE6AD6_Out_0, _Multiply_B04BDAD0_Out_2);
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_FE512398_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_FE512398_Out_2);
                float4 _SampleTexture2DLOD_F6D4A02B_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_FE512398_Out_2, 0);
                float _SampleTexture2DLOD_F6D4A02B_R_5 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.r;
                float _SampleTexture2DLOD_F6D4A02B_G_6 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.g;
                float _SampleTexture2DLOD_F6D4A02B_B_7 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.b;
                float _SampleTexture2DLOD_F6D4A02B_A_8 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.a;
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_3D189493_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_3D189493_Out_2);
                float4 _SampleTexture2DLOD_CABCD0D0_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_3D189493_Out_2, 0);
                float _SampleTexture2DLOD_CABCD0D0_R_5 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.r;
                float _SampleTexture2DLOD_CABCD0D0_G_6 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.g;
                float _SampleTexture2DLOD_CABCD0D0_B_7 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.b;
                float _SampleTexture2DLOD_CABCD0D0_A_8 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.a;
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_B4922E7C_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_B4922E7C_Out_1);
                float _Lerp_DEF9BA7B_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_F6D4A02B_A_8, _SampleTexture2DLOD_CABCD0D0_A_8, _Absolute_B4922E7C_Out_1, _Lerp_DEF9BA7B_Out_3);
                float _Add_E7355D81_Out_2;
                Unity_Add_float(_Lerp_DEF9BA7B_Out_3, -0.25, _Add_E7355D81_Out_2);
                float _Property_57308837_Out_0 = _SlowWaterTessScale;
                float _Multiply_146A3378_Out_2;
                Unity_Multiply_float(_Add_E7355D81_Out_2, _Property_57308837_Out_0, _Multiply_146A3378_Out_2);
                float _Add_42AED159_Out_2;
                Unity_Add_float(_Multiply_B04BDAD0_Out_2, _Multiply_146A3378_Out_2, _Add_42AED159_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_C675255A_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_C675255A_Out_2);
                float4 _SampleTexture2DLOD_2BB41D12_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_C675255A_Out_2, 0);
                float _SampleTexture2DLOD_2BB41D12_R_5 = _SampleTexture2DLOD_2BB41D12_RGBA_0.r;
                float _SampleTexture2DLOD_2BB41D12_G_6 = _SampleTexture2DLOD_2BB41D12_RGBA_0.g;
                float _SampleTexture2DLOD_2BB41D12_B_7 = _SampleTexture2DLOD_2BB41D12_RGBA_0.b;
                float _SampleTexture2DLOD_2BB41D12_A_8 = _SampleTexture2DLOD_2BB41D12_RGBA_0.a;
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_89DE95D0_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_89DE95D0_Out_2);
                float4 _SampleTexture2DLOD_F0E303B2_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_89DE95D0_Out_2, 0);
                float _SampleTexture2DLOD_F0E303B2_R_5 = _SampleTexture2DLOD_F0E303B2_RGBA_0.r;
                float _SampleTexture2DLOD_F0E303B2_G_6 = _SampleTexture2DLOD_F0E303B2_RGBA_0.g;
                float _SampleTexture2DLOD_F0E303B2_B_7 = _SampleTexture2DLOD_F0E303B2_RGBA_0.b;
                float _SampleTexture2DLOD_F0E303B2_A_8 = _SampleTexture2DLOD_F0E303B2_RGBA_0.a;
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float _Lerp_4F958902_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_2BB41D12_A_8, _SampleTexture2DLOD_F0E303B2_A_8, _Absolute_D56AD49D_Out_1, _Lerp_4F958902_Out_3);
                float _Add_4C244952_Out_2;
                Unity_Add_float(_Lerp_4F958902_Out_3, -0.25, _Add_4C244952_Out_2);
                float _Property_A41EED02_Out_0 = _SmallCascadeWaterTessScale;
                float _Multiply_C6FA813B_Out_2;
                Unity_Multiply_float(_Add_4C244952_Out_2, _Property_A41EED02_Out_0, _Multiply_C6FA813B_Out_2);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float _Multiply_97C7958D_Out_2;
                Unity_Multiply_float(_Multiply_C6FA813B_Out_2, _Clamp_C9BB189_Out_3, _Multiply_97C7958D_Out_2);
                float _Add_B8D97A66_Out_2;
                Unity_Add_float(_Add_42AED159_Out_2, _Multiply_97C7958D_Out_2, _Add_B8D97A66_Out_2);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_260C289D_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_260C289D_Out_2);
                float4 _SampleTexture2DLOD_27B55B65_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_260C289D_Out_2, 0);
                float _SampleTexture2DLOD_27B55B65_R_5 = _SampleTexture2DLOD_27B55B65_RGBA_0.r;
                float _SampleTexture2DLOD_27B55B65_G_6 = _SampleTexture2DLOD_27B55B65_RGBA_0.g;
                float _SampleTexture2DLOD_27B55B65_B_7 = _SampleTexture2DLOD_27B55B65_RGBA_0.b;
                float _SampleTexture2DLOD_27B55B65_A_8 = _SampleTexture2DLOD_27B55B65_RGBA_0.a;
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_672C60ED_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_672C60ED_Out_2);
                float4 _SampleTexture2DLOD_4648E9_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_672C60ED_Out_2, 0);
                float _SampleTexture2DLOD_4648E9_R_5 = _SampleTexture2DLOD_4648E9_RGBA_0.r;
                float _SampleTexture2DLOD_4648E9_G_6 = _SampleTexture2DLOD_4648E9_RGBA_0.g;
                float _SampleTexture2DLOD_4648E9_B_7 = _SampleTexture2DLOD_4648E9_RGBA_0.b;
                float _SampleTexture2DLOD_4648E9_A_8 = _SampleTexture2DLOD_4648E9_RGBA_0.a;
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Lerp_1934036C_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_27B55B65_A_8, _SampleTexture2DLOD_4648E9_A_8, _Absolute_19D4C5A5_Out_1, _Lerp_1934036C_Out_3);
                float _Add_5F941B40_Out_2;
                Unity_Add_float(_Lerp_1934036C_Out_3, -0.25, _Add_5F941B40_Out_2);
                float _Property_D14DBA62_Out_0 = _BigCascadeWaterTessScale;
                float _Multiply_131F4390_Out_2;
                Unity_Multiply_float(_Add_5F941B40_Out_2, _Property_D14DBA62_Out_0, _Multiply_131F4390_Out_2);
                float _Multiply_F5B5CD1C_Out_2;
                Unity_Multiply_float(_Multiply_131F4390_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_F5B5CD1C_Out_2);
                float _Add_2878DA0E_Out_2;
                Unity_Add_float(_Add_B8D97A66_Out_2, _Multiply_F5B5CD1C_Out_2, _Add_2878DA0E_Out_2);
                float _Split_28662C1C_R_1 = IN.VertexColor[0];
                float _Split_28662C1C_G_2 = IN.VertexColor[1];
                float _Split_28662C1C_B_3 = IN.VertexColor[2];
                float _Split_28662C1C_A_4 = IN.VertexColor[3];
                float _Lerp_A69B24EB_Out_3;
                Unity_Lerp_float(_Add_2878DA0E_Out_2, _Add_42AED159_Out_2, _Split_28662C1C_R_1, _Lerp_A69B24EB_Out_3);
                float _Lerp_B24A0C56_Out_3;
                Unity_Lerp_float(_Lerp_A69B24EB_Out_3, _Multiply_97C7958D_Out_2, _Split_28662C1C_G_2, _Lerp_B24A0C56_Out_3);
                float _Lerp_5C765D8_Out_3;
                Unity_Lerp_float(_Lerp_B24A0C56_Out_3, _Multiply_131F4390_Out_2, _Split_28662C1C_B_3, _Lerp_5C765D8_Out_3);
                float3 _Multiply_238083B9_Out_2;
                Unity_Multiply_float(IN.ObjectSpaceNormal, (_Lerp_5C765D8_Out_3.xxx), _Multiply_238083B9_Out_2);
                float3 _Add_8A04BBE9_Out_2;
                Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_238083B9_Out_2, _Add_8A04BBE9_Out_2);
                description.VertexPosition = _Add_8A04BBE9_Out_2;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 WorldSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 ScreenPosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
                float FaceSign;
            };
            
            struct SurfaceDescription
            {
                float3 Albedo;
                float3 Emission;
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float4 _ScreenPosition_1B148032_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _Property_FC343CDD_Out_0 = _Distortion;
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_7772C3BA_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_7772C3BA_Out_2);
                float4 _SampleTexture2D_91308B7C_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_7772C3BA_Out_2);
                _SampleTexture2D_91308B7C_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_91308B7C_RGBA_0);
                float _SampleTexture2D_91308B7C_R_4 = _SampleTexture2D_91308B7C_RGBA_0.r;
                float _SampleTexture2D_91308B7C_G_5 = _SampleTexture2D_91308B7C_RGBA_0.g;
                float _SampleTexture2D_91308B7C_B_6 = _SampleTexture2D_91308B7C_RGBA_0.b;
                float _SampleTexture2D_91308B7C_A_7 = _SampleTexture2D_91308B7C_RGBA_0.a;
                float _Property_BE91B4F6_Out_0 = _SlowNormalScale;
                float3 _NormalStrength_528ACD86_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_91308B7C_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_528ACD86_Out_2);
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_C1F18389_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_C1F18389_Out_2);
                float4 _SampleTexture2D_4508A259_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_C1F18389_Out_2);
                _SampleTexture2D_4508A259_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_4508A259_RGBA_0);
                float _SampleTexture2D_4508A259_R_4 = _SampleTexture2D_4508A259_RGBA_0.r;
                float _SampleTexture2D_4508A259_G_5 = _SampleTexture2D_4508A259_RGBA_0.g;
                float _SampleTexture2D_4508A259_B_6 = _SampleTexture2D_4508A259_RGBA_0.b;
                float _SampleTexture2D_4508A259_A_7 = _SampleTexture2D_4508A259_RGBA_0.a;
                float3 _NormalStrength_3BD81F5D_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_4508A259_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_3BD81F5D_Out_2);
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_6685A82A_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_6685A82A_Out_1);
                float3 _Lerp_356E067F_Out_3;
                Unity_Lerp_float3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float2 _Property_6D8A3257_Out_0 = _MicroWaveTiling;
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Multiply_ABD9AE79_Out_2;
                Unity_Multiply_float(_Property_6D8A3257_Out_0, (_Property_AA95233A_Out_0.xx), _Multiply_ABD9AE79_Out_2);
                float2 _Divide_9BA6D0A0_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_ABD9AE79_Out_2, _Divide_9BA6D0A0_Out_2);
                float2 _Multiply_9E511F45_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_9BA6D0A0_Out_2, _Multiply_9E511F45_Out_2);
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float2 _Add_4F7464A_Out_2;
                Unity_Add_float2(_Multiply_9E511F45_Out_2, _Multiply_EA842EC4_Out_2, _Add_4F7464A_Out_2);
                float3 _ChannelMask_1D6B2B0B_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_356E067F_Out_3, _ChannelMask_1D6B2B0B_Out_1);
                float3 _Multiply_9233494E_Out_2;
                Unity_Multiply_float(_ChannelMask_1D6B2B0B_Out_1, float3(0.05, 0.05, 0), _Multiply_9233494E_Out_2);
                float2 _Add_3A640853_Out_2;
                Unity_Add_float2(_Add_4F7464A_Out_2, (_Multiply_9233494E_Out_2.xy), _Add_3A640853_Out_2);
                float4 _SampleTexture2D_F765A3FA_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_3A640853_Out_2);
                _SampleTexture2D_F765A3FA_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_F765A3FA_RGBA_0);
                float _SampleTexture2D_F765A3FA_R_4 = _SampleTexture2D_F765A3FA_RGBA_0.r;
                float _SampleTexture2D_F765A3FA_G_5 = _SampleTexture2D_F765A3FA_RGBA_0.g;
                float _SampleTexture2D_F765A3FA_B_6 = _SampleTexture2D_F765A3FA_RGBA_0.b;
                float _SampleTexture2D_F765A3FA_A_7 = _SampleTexture2D_F765A3FA_RGBA_0.a;
                float2 _Vector2_70672A35_Out_0 = float2(_SampleTexture2D_F765A3FA_R_4, _SampleTexture2D_F765A3FA_G_5);
                float3 _Sign_A4C02BB9_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_A4C02BB9_Out_1);
                float _Split_10A45667_R_1 = _Sign_A4C02BB9_Out_1[0];
                float _Split_10A45667_G_2 = _Sign_A4C02BB9_Out_1[1];
                float _Split_10A45667_B_3 = _Sign_A4C02BB9_Out_1[2];
                float _Split_10A45667_A_4 = 0;
                float2 _Vector2_C260D6C2_Out_0 = float2(_Split_10A45667_G_2, 1);
                float2 _Multiply_D4982FB9_Out_2;
                Unity_Multiply_float(_Vector2_70672A35_Out_0, _Vector2_C260D6C2_Out_0, _Multiply_D4982FB9_Out_2);
                float _Split_DCB9F46D_R_1 = IN.WorldSpaceNormal[0];
                float _Split_DCB9F46D_G_2 = IN.WorldSpaceNormal[1];
                float _Split_DCB9F46D_B_3 = IN.WorldSpaceNormal[2];
                float _Split_DCB9F46D_A_4 = 0;
                float2 _Vector2_8F37EEDE_Out_0 = float2(_Split_DCB9F46D_R_1, _Split_DCB9F46D_B_3);
                float2 _Add_EDD61406_Out_2;
                Unity_Add_float2(_Multiply_D4982FB9_Out_2, _Vector2_8F37EEDE_Out_0, _Add_EDD61406_Out_2);
                float _Split_DBEE69C5_R_1 = _Add_EDD61406_Out_2[0];
                float _Split_DBEE69C5_G_2 = _Add_EDD61406_Out_2[1];
                float _Split_DBEE69C5_B_3 = 0;
                float _Split_DBEE69C5_A_4 = 0;
                float _Multiply_19C907AA_Out_2;
                Unity_Multiply_float(_SampleTexture2D_F765A3FA_B_6, _Split_DCB9F46D_G_2, _Multiply_19C907AA_Out_2);
                float3 _Vector3_CC599D5F_Out_0 = float3(_Split_DBEE69C5_R_1, _Multiply_19C907AA_Out_2, _Split_DBEE69C5_G_2);
                float3x3 Transform_E097B73C_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_E097B73C_Out_1 = TransformWorldToTangent(_Vector3_CC599D5F_Out_0.xyz, Transform_E097B73C_tangentTransform_World);
                float3 _Normalize_6560E7A8_Out_1;
                Unity_Normalize_float3(_Transform_E097B73C_Out_1, _Normalize_6560E7A8_Out_1);
                float _Property_7246E682_Out_0 = _MicroWaveNormalScale;
                float3 _NormalStrength_E984BDF9_Out_2;
                Unity_NormalStrength_float(_Normalize_6560E7A8_Out_1, _Property_7246E682_Out_0, _NormalStrength_E984BDF9_Out_2);
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float2 _Add_B51BFC_Out_2;
                Unity_Add_float2(_Add_4ECADB09_Out_2, (_Multiply_9233494E_Out_2.xy), _Add_B51BFC_Out_2);
                float4 _SampleTexture2D_49A71497_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_B51BFC_Out_2);
                _SampleTexture2D_49A71497_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_49A71497_RGBA_0);
                float _SampleTexture2D_49A71497_R_4 = _SampleTexture2D_49A71497_RGBA_0.r;
                float _SampleTexture2D_49A71497_G_5 = _SampleTexture2D_49A71497_RGBA_0.g;
                float _SampleTexture2D_49A71497_B_6 = _SampleTexture2D_49A71497_RGBA_0.b;
                float _SampleTexture2D_49A71497_A_7 = _SampleTexture2D_49A71497_RGBA_0.a;
                float2 _Vector2_EE92CBEE_Out_0 = float2(_SampleTexture2D_49A71497_R_4, _SampleTexture2D_49A71497_G_5);
                float3 _Sign_CE4A6EE0_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_CE4A6EE0_Out_1);
                float _Split_717E3A76_R_1 = _Sign_CE4A6EE0_Out_1[0];
                float _Split_717E3A76_G_2 = _Sign_CE4A6EE0_Out_1[1];
                float _Split_717E3A76_B_3 = _Sign_CE4A6EE0_Out_1[2];
                float _Split_717E3A76_A_4 = 0;
                float2 _Vector2_43391560_Out_0 = float2(_Split_717E3A76_G_2, 1);
                float2 _Multiply_4D74E9F7_Out_2;
                Unity_Multiply_float(_Vector2_EE92CBEE_Out_0, _Vector2_43391560_Out_0, _Multiply_4D74E9F7_Out_2);
                float _Split_1E9BE17E_R_1 = IN.WorldSpaceNormal[0];
                float _Split_1E9BE17E_G_2 = IN.WorldSpaceNormal[1];
                float _Split_1E9BE17E_B_3 = IN.WorldSpaceNormal[2];
                float _Split_1E9BE17E_A_4 = 0;
                float2 _Vector2_7FB5264B_Out_0 = float2(_Split_1E9BE17E_R_1, _Split_1E9BE17E_B_3);
                float2 _Add_398D7267_Out_2;
                Unity_Add_float2(_Multiply_4D74E9F7_Out_2, _Vector2_7FB5264B_Out_0, _Add_398D7267_Out_2);
                float _Split_5414ACAC_R_1 = _Add_398D7267_Out_2[0];
                float _Split_5414ACAC_G_2 = _Add_398D7267_Out_2[1];
                float _Split_5414ACAC_B_3 = 0;
                float _Split_5414ACAC_A_4 = 0;
                float _Multiply_80133872_Out_2;
                Unity_Multiply_float(_SampleTexture2D_49A71497_B_6, _Split_1E9BE17E_G_2, _Multiply_80133872_Out_2);
                float3 _Vector3_336A482E_Out_0 = float3(_Split_5414ACAC_R_1, _Multiply_80133872_Out_2, _Split_5414ACAC_G_2);
                float3x3 Transform_5FC79949_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_5FC79949_Out_1 = TransformWorldToTangent(_Vector3_336A482E_Out_0.xyz, Transform_5FC79949_tangentTransform_World);
                float3 _Normalize_F8AB1C98_Out_1;
                Unity_Normalize_float3(_Transform_5FC79949_Out_1, _Normalize_F8AB1C98_Out_1);
                float _Property_EE02697B_Out_0 = _MacroWaveNormalScale;
                float3 _NormalStrength_3E2CC83C_Out_2;
                Unity_NormalStrength_float(_Normalize_F8AB1C98_Out_1, _Property_EE02697B_Out_0, _NormalStrength_3E2CC83C_Out_2);
                float3 _NormalBlend_942EAE7_Out_2;
                Unity_NormalBlend_float(_NormalStrength_E984BDF9_Out_2, _NormalStrength_3E2CC83C_Out_2, _NormalBlend_942EAE7_Out_2);
                float3 _NormalBlend_412E2B77_Out_2;
                Unity_NormalBlend_float(_Lerp_356E067F_Out_3, _NormalBlend_942EAE7_Out_2, _NormalBlend_412E2B77_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_188C8FD3_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_188C8FD3_Out_2);
                float4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeNormal, sampler_SmallCascadeNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                float _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                float _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                float _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                float _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                float _Property_8A81F679_Out_0 = _SmallCascadeNormalScale;
                float3 _NormalStrength_94FC33DB_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_AEBC8292_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_94FC33DB_Out_2);
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_3E5AC13E_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_3E5AC13E_Out_2);
                float4 _SampleTexture2D_9126225F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeNormal, sampler_SmallCascadeNormal, _Add_3E5AC13E_Out_2);
                _SampleTexture2D_9126225F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9126225F_RGBA_0);
                float _SampleTexture2D_9126225F_R_4 = _SampleTexture2D_9126225F_RGBA_0.r;
                float _SampleTexture2D_9126225F_G_5 = _SampleTexture2D_9126225F_RGBA_0.g;
                float _SampleTexture2D_9126225F_B_6 = _SampleTexture2D_9126225F_RGBA_0.b;
                float _SampleTexture2D_9126225F_A_7 = _SampleTexture2D_9126225F_RGBA_0.a;
                float3 _NormalStrength_337B983B_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_9126225F_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_337B983B_Out_2);
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float3 _Lerp_5B898C96_Out_3;
                Unity_Lerp_float3(_NormalStrength_94FC33DB_Out_2, _NormalStrength_337B983B_Out_2, (_Absolute_D56AD49D_Out_1.xxx), _Lerp_5B898C96_Out_3);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_float3(_NormalBlend_412E2B77_Out_2, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_D29A7CEF_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_D29A7CEF_Out_2);
                float4 _SampleTexture2D_6ABE710E_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascadeNormal, sampler_BigCascadeNormal, _Add_D29A7CEF_Out_2);
                _SampleTexture2D_6ABE710E_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6ABE710E_RGBA_0);
                float _SampleTexture2D_6ABE710E_R_4 = _SampleTexture2D_6ABE710E_RGBA_0.r;
                float _SampleTexture2D_6ABE710E_G_5 = _SampleTexture2D_6ABE710E_RGBA_0.g;
                float _SampleTexture2D_6ABE710E_B_6 = _SampleTexture2D_6ABE710E_RGBA_0.b;
                float _SampleTexture2D_6ABE710E_A_7 = _SampleTexture2D_6ABE710E_RGBA_0.a;
                float _Property_944CEF1C_Out_0 = _BigCascadeNormalScale;
                float3 _NormalStrength_8AA324A2_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_6ABE710E_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8AA324A2_Out_2);
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_47CB0CEA_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_47CB0CEA_Out_2);
                float4 _SampleTexture2D_6FC3A421_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascadeNormal, sampler_BigCascadeNormal, _Add_47CB0CEA_Out_2);
                _SampleTexture2D_6FC3A421_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6FC3A421_RGBA_0);
                float _SampleTexture2D_6FC3A421_R_4 = _SampleTexture2D_6FC3A421_RGBA_0.r;
                float _SampleTexture2D_6FC3A421_G_5 = _SampleTexture2D_6FC3A421_RGBA_0.g;
                float _SampleTexture2D_6FC3A421_B_6 = _SampleTexture2D_6FC3A421_RGBA_0.b;
                float _SampleTexture2D_6FC3A421_A_7 = _SampleTexture2D_6FC3A421_RGBA_0.a;
                float3 _NormalStrength_8264A1B8_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_6FC3A421_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8264A1B8_Out_2);
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float3 _Lerp_F884F066_Out_3;
                Unity_Lerp_float3(_NormalStrength_8AA324A2_Out_2, _NormalStrength_8264A1B8_Out_2, (_Absolute_19D4C5A5_Out_1.xxx), _Lerp_F884F066_Out_3);
                float3 _Lerp_C8A32E85_Out_3;
                Unity_Lerp_float3(_Lerp_BA2C71FD_Out_3, _Lerp_F884F066_Out_3, (_Clamp_C3D0E6D0_Out_3.xxx), _Lerp_C8A32E85_Out_3);
                float _Split_42E433A0_R_1 = IN.VertexColor[0];
                float _Split_42E433A0_G_2 = IN.VertexColor[1];
                float _Split_42E433A0_B_3 = IN.VertexColor[2];
                float _Split_42E433A0_A_4 = IN.VertexColor[3];
                float3 _Lerp_556A8C4B_Out_3;
                Unity_Lerp_float3(_Lerp_C8A32E85_Out_3, _NormalBlend_412E2B77_Out_2, (_Split_42E433A0_R_1.xxx), _Lerp_556A8C4B_Out_3);
                float3 _Lerp_CD3A5C6C_Out_3;
                Unity_Lerp_float3(_Lerp_556A8C4B_Out_3, _Lerp_5B898C96_Out_3, (_Split_42E433A0_G_2.xxx), _Lerp_CD3A5C6C_Out_3);
                float3 _Lerp_52D4237F_Out_3;
                Unity_Lerp_float3(_Lerp_CD3A5C6C_Out_3, _Lerp_F884F066_Out_3, (_Split_42E433A0_B_3.xxx), _Lerp_52D4237F_Out_3);
                float _Property_C2D9BD80_Out_0 = _FarNormalPower;
                float3 _Vector3_3A6917E5_Out_0 = float3(_Property_C2D9BD80_Out_0, _Property_C2D9BD80_Out_0, 1);
                float3 _Multiply_C66EC037_Out_2;
                Unity_Multiply_float(_Vector3_3A6917E5_Out_0, _Lerp_52D4237F_Out_3, _Multiply_C66EC037_Out_2);
                float _Distance_2BC7BAC4_Out_2;
                Unity_Distance_float3(IN.AbsoluteWorldSpacePosition, _WorldSpaceCameraPos, _Distance_2BC7BAC4_Out_2);
                float _Property_F830ADD1_Out_0 = _FarNormalBlendStartDistance;
                float _Divide_FD4E31CF_Out_2;
                Unity_Divide_float(_Distance_2BC7BAC4_Out_2, _Property_F830ADD1_Out_0, _Divide_FD4E31CF_Out_2);
                float _Absolute_C7759968_Out_1;
                Unity_Absolute_float(_Divide_FD4E31CF_Out_2, _Absolute_C7759968_Out_1);
                float _Property_793038B1_Out_0 = _FarNormalBlendThreshold;
                float _Power_B974F588_Out_2;
                Unity_Power_float(_Absolute_C7759968_Out_1, _Property_793038B1_Out_0, _Power_B974F588_Out_2);
                float _Clamp_92AA7C53_Out_3;
                Unity_Clamp_float(_Power_B974F588_Out_2, 0, 1, _Clamp_92AA7C53_Out_3);
                float3 _Lerp_72DCEC20_Out_3;
                Unity_Lerp_float3(_Lerp_52D4237F_Out_3, _Multiply_C66EC037_Out_2, (_Clamp_92AA7C53_Out_3.xxx), _Lerp_72DCEC20_Out_3);
                float3 _Normalize_17DCA406_Out_1;
                Unity_Normalize_float3(_Lerp_72DCEC20_Out_3, _Normalize_17DCA406_Out_1);
                float _Split_6A7D546B_R_1 = _Normalize_17DCA406_Out_1[0];
                float _Split_6A7D546B_G_2 = _Normalize_17DCA406_Out_1[1];
                float _Split_6A7D546B_B_3 = _Normalize_17DCA406_Out_1[2];
                float _Split_6A7D546B_A_4 = 0;
                float4 _Combine_E07639F2_RGBA_4;
                float3 _Combine_E07639F2_RGB_5;
                float2 _Combine_E07639F2_RG_6;
                Unity_Combine_float(_Split_6A7D546B_R_1, _Split_6A7D546B_G_2, 0, 0, _Combine_E07639F2_RGBA_4, _Combine_E07639F2_RGB_5, _Combine_E07639F2_RG_6);
                float2 _Multiply_2F7622D8_Out_2;
                Unity_Multiply_float((_Property_FC343CDD_Out_0.xx), _Combine_E07639F2_RG_6, _Multiply_2F7622D8_Out_2);
                float2 _Multiply_9F154179_Out_2;
                Unity_Multiply_float((_ScreenPosition_1B148032_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_9F154179_Out_2);
                float2 _Add_FCAE1710_Out_2;
                Unity_Add_float2((_ScreenPosition_1B148032_Out_0.xy), _Multiply_9F154179_Out_2, _Add_FCAE1710_Out_2);
                float3 _SceneColor_5A25EB33_Out_1;
                Unity_SceneColor_float((float4(_Add_FCAE1710_Out_2, 0.0, 1.0)), _SceneColor_5A25EB33_Out_1);
                float4 _Property_C4180B07_Out_0 = _DeepColor;
                float4 _Property_B354F529_Out_0 = _ShalowColor;
                float4 _ScreenPosition_E4782AF8_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_float(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                float _Multiply_39A1673A_Out_2;
                Unity_Multiply_float(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                float4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                float _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                float _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                float _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                float _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                float _Subtract_331D19CE_Out_2;
                Unity_Subtract_float(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                float _Property_46A80510_Out_0 = _ShalowFalloffMultiply;
                float _Multiply_55CDC796_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_46A80510_Out_0, _Multiply_55CDC796_Out_2);
                float _Absolute_DA749514_Out_1;
                Unity_Absolute_float(_Multiply_55CDC796_Out_2, _Absolute_DA749514_Out_1);
                float _Property_4D681D1C_Out_0 = _ShalowFalloffPower;
                float _Multiply_F7AB70ED_Out_2;
                Unity_Multiply_float(_Property_4D681D1C_Out_0, -1, _Multiply_F7AB70ED_Out_2);
                float _Power_3270BF29_Out_2;
                Unity_Power_float(_Absolute_DA749514_Out_1, _Multiply_F7AB70ED_Out_2, _Power_3270BF29_Out_2);
                float _Property_BB1D3A49_Out_0 = _BigCascadeTransparency;
                float _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_float(_Property_BB1D3A49_Out_0, _Clamp_C3D0E6D0_Out_3, _Multiply_6F5E4CCF_Out_2);
                float _Lerp_FE3B891E_Out_3;
                Unity_Lerp_float(_Power_3270BF29_Out_2, 100, _Multiply_6F5E4CCF_Out_2, _Lerp_FE3B891E_Out_3);
                float _Saturate_47EA3698_Out_1;
                Unity_Saturate_float(_Lerp_FE3B891E_Out_3, _Saturate_47EA3698_Out_1);
                float _Clamp_FA371D5_Out_3;
                Unity_Clamp_float(_Saturate_47EA3698_Out_1, 0, 1, _Clamp_FA371D5_Out_3);
                float4 _Lerp_E98C0337_Out_3;
                Unity_Lerp_float4(_Property_C4180B07_Out_0, _Property_B354F529_Out_0, (_Clamp_FA371D5_Out_3.xxxx), _Lerp_E98C0337_Out_3);
                float4 _SampleTexture2D_13F501DC_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_B51BFC_Out_2);
                float _SampleTexture2D_13F501DC_R_4 = _SampleTexture2D_13F501DC_RGBA_0.r;
                float _SampleTexture2D_13F501DC_G_5 = _SampleTexture2D_13F501DC_RGBA_0.g;
                float _SampleTexture2D_13F501DC_B_6 = _SampleTexture2D_13F501DC_RGBA_0.b;
                float _SampleTexture2D_13F501DC_A_7 = _SampleTexture2D_13F501DC_RGBA_0.a;
                float _Property_DF347AFD_Out_0 = _SlowWaterTranslucencyMultiply;
                float _Multiply_12D281E6_Out_2;
                Unity_Multiply_float(_SampleTexture2D_13F501DC_A_7, _Property_DF347AFD_Out_0, _Multiply_12D281E6_Out_2);
                float4 _SampleTexture2D_C713F57F_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_7772C3BA_Out_2);
                float _SampleTexture2D_C713F57F_R_4 = _SampleTexture2D_C713F57F_RGBA_0.r;
                float _SampleTexture2D_C713F57F_G_5 = _SampleTexture2D_C713F57F_RGBA_0.g;
                float _SampleTexture2D_C713F57F_B_6 = _SampleTexture2D_C713F57F_RGBA_0.b;
                float _SampleTexture2D_C713F57F_A_7 = _SampleTexture2D_C713F57F_RGBA_0.a;
                float4 _SampleTexture2D_5CD91024_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_C1F18389_Out_2);
                float _SampleTexture2D_5CD91024_R_4 = _SampleTexture2D_5CD91024_RGBA_0.r;
                float _SampleTexture2D_5CD91024_G_5 = _SampleTexture2D_5CD91024_RGBA_0.g;
                float _SampleTexture2D_5CD91024_B_6 = _SampleTexture2D_5CD91024_RGBA_0.b;
                float _SampleTexture2D_5CD91024_A_7 = _SampleTexture2D_5CD91024_RGBA_0.a;
                float _Lerp_AFD3E4F7_Out_3;
                Unity_Lerp_float(_SampleTexture2D_C713F57F_A_7, _SampleTexture2D_5CD91024_A_7, _Absolute_6685A82A_Out_1, _Lerp_AFD3E4F7_Out_3);
                float _Multiply_38871AB2_Out_2;
                Unity_Multiply_float(_Lerp_AFD3E4F7_Out_3, _Property_DF347AFD_Out_0, _Multiply_38871AB2_Out_2);
                float _Add_6B3A33E0_Out_2;
                Unity_Add_float(_Multiply_12D281E6_Out_2, _Multiply_38871AB2_Out_2, _Add_6B3A33E0_Out_2);
                float4 _SampleTexture2D_28CB720F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_188C8FD3_Out_2);
                float _SampleTexture2D_28CB720F_R_4 = _SampleTexture2D_28CB720F_RGBA_0.r;
                float _SampleTexture2D_28CB720F_G_5 = _SampleTexture2D_28CB720F_RGBA_0.g;
                float _SampleTexture2D_28CB720F_B_6 = _SampleTexture2D_28CB720F_RGBA_0.b;
                float _SampleTexture2D_28CB720F_A_7 = _SampleTexture2D_28CB720F_RGBA_0.a;
                float4 _SampleTexture2D_8FF1FC6F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_3E5AC13E_Out_2);
                float _SampleTexture2D_8FF1FC6F_R_4 = _SampleTexture2D_8FF1FC6F_RGBA_0.r;
                float _SampleTexture2D_8FF1FC6F_G_5 = _SampleTexture2D_8FF1FC6F_RGBA_0.g;
                float _SampleTexture2D_8FF1FC6F_B_6 = _SampleTexture2D_8FF1FC6F_RGBA_0.b;
                float _SampleTexture2D_8FF1FC6F_A_7 = _SampleTexture2D_8FF1FC6F_RGBA_0.a;
                float _Lerp_4087DCAB_Out_3;
                Unity_Lerp_float(_SampleTexture2D_28CB720F_A_7, _SampleTexture2D_8FF1FC6F_A_7, _Absolute_D56AD49D_Out_1, _Lerp_4087DCAB_Out_3);
                float _Multiply_886F60D0_Out_2;
                Unity_Multiply_float(_Lerp_4087DCAB_Out_3, _Clamp_C9BB189_Out_3, _Multiply_886F60D0_Out_2);
                float _Property_34EA6884_Out_0 = _SmallCascadeTranslucencyMultiply;
                float _Multiply_A5195DC2_Out_2;
                Unity_Multiply_float(_Multiply_886F60D0_Out_2, _Property_34EA6884_Out_0, _Multiply_A5195DC2_Out_2);
                float _Add_DB50B67C_Out_2;
                Unity_Add_float(_Add_6B3A33E0_Out_2, _Multiply_A5195DC2_Out_2, _Add_DB50B67C_Out_2);
                float4 _SampleTexture2D_3D04E744_RGBA_0 = SAMPLE_TEXTURE2D(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_D29A7CEF_Out_2);
                float _SampleTexture2D_3D04E744_R_4 = _SampleTexture2D_3D04E744_RGBA_0.r;
                float _SampleTexture2D_3D04E744_G_5 = _SampleTexture2D_3D04E744_RGBA_0.g;
                float _SampleTexture2D_3D04E744_B_6 = _SampleTexture2D_3D04E744_RGBA_0.b;
                float _SampleTexture2D_3D04E744_A_7 = _SampleTexture2D_3D04E744_RGBA_0.a;
                float4 _SampleTexture2D_FDC3D2E_RGBA_0 = SAMPLE_TEXTURE2D(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_47CB0CEA_Out_2);
                float _SampleTexture2D_FDC3D2E_R_4 = _SampleTexture2D_FDC3D2E_RGBA_0.r;
                float _SampleTexture2D_FDC3D2E_G_5 = _SampleTexture2D_FDC3D2E_RGBA_0.g;
                float _SampleTexture2D_FDC3D2E_B_6 = _SampleTexture2D_FDC3D2E_RGBA_0.b;
                float _SampleTexture2D_FDC3D2E_A_7 = _SampleTexture2D_FDC3D2E_RGBA_0.a;
                float _Lerp_627AFBE_Out_3;
                Unity_Lerp_float(_SampleTexture2D_3D04E744_A_7, _SampleTexture2D_FDC3D2E_A_7, _Absolute_19D4C5A5_Out_1, _Lerp_627AFBE_Out_3);
                float _Property_928C8D62_Out_0 = _BigCascadeTranslucencyMultiply;
                float _Multiply_5E3A9C4F_Out_2;
                Unity_Multiply_float(_Lerp_627AFBE_Out_3, _Property_928C8D62_Out_0, _Multiply_5E3A9C4F_Out_2);
                float _Multiply_985131BF_Out_2;
                Unity_Multiply_float(_Multiply_5E3A9C4F_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_985131BF_Out_2);
                float _Add_48913743_Out_2;
                Unity_Add_float(_Add_DB50B67C_Out_2, _Multiply_985131BF_Out_2, _Add_48913743_Out_2);
                float _Lerp_9F2FC6DE_Out_3;
                Unity_Lerp_float(_Add_48913743_Out_2, _Add_6B3A33E0_Out_2, _Split_42E433A0_R_1, _Lerp_9F2FC6DE_Out_3);
                float _Lerp_FB484DB5_Out_3;
                Unity_Lerp_float(_Lerp_9F2FC6DE_Out_3, _Multiply_A5195DC2_Out_2, _Split_42E433A0_G_2, _Lerp_FB484DB5_Out_3);
                float _Lerp_895F9AAF_Out_3;
                Unity_Lerp_float(_Lerp_FB484DB5_Out_3, _Multiply_985131BF_Out_2, _Split_42E433A0_B_3, _Lerp_895F9AAF_Out_3);
                float _Property_34B150E6_Out_0 = _WaveTranslucencyHardness;
                float _Multiply_814E887D_Out_2;
                Unity_Multiply_float(_Lerp_895F9AAF_Out_3, _Property_34B150E6_Out_0, _Multiply_814E887D_Out_2);
                float _Absolute_48E4873A_Out_1;
                Unity_Absolute_float(_Multiply_814E887D_Out_2, _Absolute_48E4873A_Out_1);
                float _Property_9EFC9ABB_Out_0 = _WaveTranslucencyPower;
                float _Power_4A7A9922_Out_2;
                Unity_Power_float(_Absolute_48E4873A_Out_1, _Property_9EFC9ABB_Out_0, _Power_4A7A9922_Out_2);
                float _Property_CC520751_Out_0 = _WaveTranslucencyMultiply;
                float _Multiply_A80435F6_Out_2;
                Unity_Multiply_float(_Power_4A7A9922_Out_2, _Property_CC520751_Out_0, _Multiply_A80435F6_Out_2);
                float _Property_4A52B221_Out_0 = _WaveTranslucencyFallOffDistance;
                float _Divide_9A2ADE25_Out_2;
                Unity_Divide_float(_Distance_2BC7BAC4_Out_2, _Property_4A52B221_Out_0, _Divide_9A2ADE25_Out_2);
                float _Lerp_2EB5E047_Out_3;
                Unity_Lerp_float(_Multiply_A80435F6_Out_2, 0, _Divide_9A2ADE25_Out_2, _Lerp_2EB5E047_Out_3);
                float _Clamp_844D27EC_Out_3;
                Unity_Clamp_float(_Lerp_2EB5E047_Out_3, 0, 1, _Clamp_844D27EC_Out_3);
                float4 _Lerp_B4C04BFD_Out_3;
                Unity_Lerp_float4(_Lerp_E98C0337_Out_3, _Property_B354F529_Out_0, (_Clamp_844D27EC_Out_3.xxxx), _Lerp_B4C04BFD_Out_3);
                float3 _Multiply_D633B72E_Out_2;
                Unity_Multiply_float((_Lerp_B4C04BFD_Out_3.xyz), _SceneColor_5A25EB33_Out_1, _Multiply_D633B72E_Out_2);
                float _Property_6D149C33_Out_0 = _WaterAlphaMultiply;
                float _Multiply_BFF3EB6E_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_6D149C33_Out_0, _Multiply_BFF3EB6E_Out_2);
                float _Clamp_D42DB1DE_Out_3;
                Unity_Clamp_float(_Multiply_BFF3EB6E_Out_2, 0, 1, _Clamp_D42DB1DE_Out_3);
                float _Property_BF7B7D6B_Out_0 = _WaterAlphaPower;
                float _Power_84CE25F5_Out_2;
                Unity_Power_float(_Clamp_D42DB1DE_Out_3, _Property_BF7B7D6B_Out_0, _Power_84CE25F5_Out_2);
                float _Clamp_F8CBC0B_Out_3;
                Unity_Clamp_float(_Power_84CE25F5_Out_2, 0, 1, _Clamp_F8CBC0B_Out_3);
                float3 _Lerp_E9A0ECDE_Out_3;
                Unity_Lerp_float3(_Multiply_D633B72E_Out_2, (_Lerp_B4C04BFD_Out_3.xyz), (_Clamp_F8CBC0B_Out_3.xxx), _Lerp_E9A0ECDE_Out_3);
                float _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                float _Multiply_312FB549_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                float _Clamp_43A46A4A_Out_3;
                Unity_Clamp_float(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                float _Absolute_97151155_Out_1;
                Unity_Absolute_float(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                float _Property_D7C9F55F_Out_0 = _CleanFalloffPower;
                float _Power_AD928E85_Out_2;
                Unity_Power_float(_Absolute_97151155_Out_1, _Property_D7C9F55F_Out_0, _Power_AD928E85_Out_2);
                float _Clamp_9B4149BD_Out_3;
                Unity_Clamp_float(_Power_AD928E85_Out_2, 0, 1, _Clamp_9B4149BD_Out_3);
                float3 _Lerp_DF8F6DB6_Out_3;
                Unity_Lerp_float3(_SceneColor_5A25EB33_Out_1, _Lerp_E9A0ECDE_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_DF8F6DB6_Out_3);
                float3 _Property_71824DF9_Out_0 = _FoamColor;
                float _Property_6A3E12E9_Out_0 = _FoamDepth;
                float _Add_D65144A5_Out_2;
                Unity_Add_float(_Subtract_331D19CE_Out_2, _Property_6A3E12E9_Out_0, _Add_D65144A5_Out_2);
                float _Absolute_236EA369_Out_1;
                Unity_Absolute_float(_Add_D65144A5_Out_2, _Absolute_236EA369_Out_1);
                float _Property_5092872F_Out_0 = _FoamFalloff;
                float _Power_C278752C_Out_2;
                Unity_Power_float(_Absolute_236EA369_Out_1, _Property_5092872F_Out_0, _Power_C278752C_Out_2);
                float _Saturate_F768EEA6_Out_1;
                Unity_Saturate_float(_Power_C278752C_Out_2, _Saturate_F768EEA6_Out_1);
                float _Property_A8CF8708_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_25764F01_Out_0 = _FoamSpeed;
                float2 _Property_3E47978_Out_0 = _FoamTiling;
                float2 _Multiply_DE80E1D6_Out_2;
                Unity_Multiply_float(_Property_25764F01_Out_0, _Property_3E47978_Out_0, _Multiply_DE80E1D6_Out_2);
                float4 _UV_E1385FB5_Out_0 = IN.uv3;
                float2 _Multiply_3C9DE3D3_Out_2;
                Unity_Multiply_float(_Multiply_DE80E1D6_Out_2, (_UV_E1385FB5_Out_0.xy), _Multiply_3C9DE3D3_Out_2);
                float _Split_90264A5B_R_1 = _Multiply_3C9DE3D3_Out_2[0];
                float _Split_90264A5B_G_2 = _Multiply_3C9DE3D3_Out_2[1];
                float _Split_90264A5B_B_3 = 0;
                float _Split_90264A5B_A_4 = 0;
                float2 _Vector2_8C003284_Out_0 = float2(_Split_90264A5B_G_2, _Split_90264A5B_R_1);
                float2 _Branch_81C13B1A_Out_3;
                Unity_Branch_float2(_Property_A8CF8708_Out_0, _Multiply_3C9DE3D3_Out_2, _Vector2_8C003284_Out_0, _Branch_81C13B1A_Out_3);
                float2 _Multiply_F37F0047_Out_2;
                Unity_Multiply_float(_Branch_81C13B1A_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_F37F0047_Out_2);
                float _Property_70842CE7_Out_0 = _GlobalTiling;
                float _Divide_D13271E5_Out_2;
                Unity_Divide_float(1, _Property_70842CE7_Out_0, _Divide_D13271E5_Out_2);
                float4 _UV_E210B498_Out_0 = IN.uv0;
                float2 _Multiply_38B9004E_Out_2;
                Unity_Multiply_float(_Property_3E47978_Out_0, (_UV_E210B498_Out_0.xy), _Multiply_38B9004E_Out_2);
                float2 _Multiply_FED7B7C8_Out_2;
                Unity_Multiply_float((_Divide_D13271E5_Out_2.xx), _Multiply_38B9004E_Out_2, _Multiply_FED7B7C8_Out_2);
                float2 _Add_F1148D00_Out_2;
                Unity_Add_float2(_Multiply_F37F0047_Out_2, _Multiply_FED7B7C8_Out_2, _Add_F1148D00_Out_2);
                float3 _ChannelMask_70068C75_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_BA2C71FD_Out_3, _ChannelMask_70068C75_Out_1);
                float3 _Multiply_134985D4_Out_2;
                Unity_Multiply_float(_ChannelMask_70068C75_Out_1, float3(0.03, 0.03, 0), _Multiply_134985D4_Out_2);
                float2 _Add_C3A54034_Out_2;
                Unity_Add_float2(_Add_F1148D00_Out_2, (_Multiply_134985D4_Out_2.xy), _Add_C3A54034_Out_2);
                float4 _SampleTexture2D_D6FF940D_RGBA_0 = SAMPLE_TEXTURE2D(_Foam, sampler_Foam, _Add_C3A54034_Out_2);
                float _SampleTexture2D_D6FF940D_R_4 = _SampleTexture2D_D6FF940D_RGBA_0.r;
                float _SampleTexture2D_D6FF940D_G_5 = _SampleTexture2D_D6FF940D_RGBA_0.g;
                float _SampleTexture2D_D6FF940D_B_6 = _SampleTexture2D_D6FF940D_RGBA_0.b;
                float _SampleTexture2D_D6FF940D_A_7 = _SampleTexture2D_D6FF940D_RGBA_0.a;
                float2 _Multiply_3FB3476F_Out_2;
                Unity_Multiply_float(_Branch_81C13B1A_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_3FB3476F_Out_2);
                float2 _Add_7633CAE7_Out_2;
                Unity_Add_float2(_Multiply_FED7B7C8_Out_2, _Multiply_3FB3476F_Out_2, _Add_7633CAE7_Out_2);
                float2 _Add_14D7BEE1_Out_2;
                Unity_Add_float2(_Add_7633CAE7_Out_2, (_Multiply_134985D4_Out_2.xy), _Add_14D7BEE1_Out_2);
                float4 _SampleTexture2D_80481243_RGBA_0 = SAMPLE_TEXTURE2D(_Foam, sampler_Foam, _Add_14D7BEE1_Out_2);
                float _SampleTexture2D_80481243_R_4 = _SampleTexture2D_80481243_RGBA_0.r;
                float _SampleTexture2D_80481243_G_5 = _SampleTexture2D_80481243_RGBA_0.g;
                float _SampleTexture2D_80481243_B_6 = _SampleTexture2D_80481243_RGBA_0.b;
                float _SampleTexture2D_80481243_A_7 = _SampleTexture2D_80481243_RGBA_0.a;
                float _Lerp_408AE005_Out_3;
                Unity_Lerp_float(_SampleTexture2D_D6FF940D_A_7, _SampleTexture2D_80481243_A_7, _Absolute_6685A82A_Out_1, _Lerp_408AE005_Out_3);
                float _Multiply_CE5D1661_Out_2;
                Unity_Multiply_float(_Saturate_F768EEA6_Out_1, _Lerp_408AE005_Out_3, _Multiply_CE5D1661_Out_2);
                float _Lerp_25030EB5_Out_3;
                Unity_Lerp_float(_Multiply_CE5D1661_Out_2, 0, _Clamp_C3D0E6D0_Out_3, _Lerp_25030EB5_Out_3);
                float _Clamp_CDFBCC47_Out_3;
                Unity_Clamp_float(_Lerp_25030EB5_Out_3, 0, 1, _Clamp_CDFBCC47_Out_3);
                float _Property_C10720A6_Out_0 = _FoamWaveHardness;
                float _Multiply_E0985C9B_Out_2;
                Unity_Multiply_float(_Lerp_AFD3E4F7_Out_3, _Property_C10720A6_Out_0, _Multiply_E0985C9B_Out_2);
                float _Absolute_47BFD663_Out_1;
                Unity_Absolute_float(_Multiply_E0985C9B_Out_2, _Absolute_47BFD663_Out_1);
                float _Property_7556FCA1_Out_0 = _FoamWavePower;
                float _Power_E4C90FA4_Out_2;
                Unity_Power_float(_Absolute_47BFD663_Out_1, _Property_7556FCA1_Out_0, _Power_E4C90FA4_Out_2);
                float _Property_C5E24EE_Out_0 = _FoamWaveMultiply;
                float _Multiply_49E6B3AD_Out_2;
                Unity_Multiply_float(_Power_E4C90FA4_Out_2, _Property_C5E24EE_Out_0, _Multiply_49E6B3AD_Out_2);
                float _Clamp_41A39F5E_Out_3;
                Unity_Clamp_float(_Multiply_49E6B3AD_Out_2, 0, 1, _Clamp_41A39F5E_Out_3);
                float _Multiply_6E6B7134_Out_2;
                Unity_Multiply_float(_Clamp_CDFBCC47_Out_3, _Clamp_41A39F5E_Out_3, _Multiply_6E6B7134_Out_2);
                float3 _Lerp_6998DF58_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Property_71824DF9_Out_0, (_Multiply_6E6B7134_Out_2.xxx), _Lerp_6998DF58_Out_3);
                float4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascade, sampler_SmallCascade, _Add_188C8FD3_Out_2);
                float _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                float _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                float _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                float _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                float4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascade, sampler_SmallCascade, _Add_3E5AC13E_Out_2);
                float _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                float _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                float _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                float _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                float _Blend_A1B262EF_Out_2;
                Unity_Blend_Overwrite_float(_SampleTexture2D_B8ACE3F1_A_7, _SampleTexture2D_A1621BBD_A_7, _Blend_A1B262EF_Out_2, _Absolute_D56AD49D_Out_1);
                float _Property_50DF1CAB_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_A4A55C8D_Out_0 = _NoiseSpeed;
                float2 _Property_986C2E1B_Out_0 = _NoiseTiling;
                float2 _Multiply_778A9500_Out_2;
                Unity_Multiply_float(_Property_A4A55C8D_Out_0, _Property_986C2E1B_Out_0, _Multiply_778A9500_Out_2);
                float4 _UV_4A477E20_Out_0 = IN.uv3;
                float2 _Multiply_E53528CB_Out_2;
                Unity_Multiply_float(_Multiply_778A9500_Out_2, (_UV_4A477E20_Out_0.xy), _Multiply_E53528CB_Out_2);
                float _Split_A3C5F2B5_R_1 = _Multiply_E53528CB_Out_2[0];
                float _Split_A3C5F2B5_G_2 = _Multiply_E53528CB_Out_2[1];
                float _Split_A3C5F2B5_B_3 = 0;
                float _Split_A3C5F2B5_A_4 = 0;
                float2 _Vector2_6D67D273_Out_0 = float2(_Split_A3C5F2B5_G_2, _Split_A3C5F2B5_R_1);
                float2 _Branch_EDA2C0E3_Out_3;
                Unity_Branch_float2(_Property_50DF1CAB_Out_0, _Multiply_E53528CB_Out_2, _Vector2_6D67D273_Out_0, _Branch_EDA2C0E3_Out_3);
                float _Fraction_2FBB1852_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_2FBB1852_Out_1);
                float2 _Multiply_39A54641_Out_2;
                Unity_Multiply_float(_Branch_EDA2C0E3_Out_3, (_Fraction_2FBB1852_Out_1.xx), _Multiply_39A54641_Out_2);
                float _Property_82193ED3_Out_0 = _GlobalTiling;
                float _Divide_411EED11_Out_2;
                Unity_Divide_float(1, _Property_82193ED3_Out_0, _Divide_411EED11_Out_2);
                float4 _UV_F9D3A262_Out_0 = IN.uv0;
                float2 _Multiply_9C31F9C2_Out_2;
                Unity_Multiply_float(_Property_986C2E1B_Out_0, (_UV_F9D3A262_Out_0.xy), _Multiply_9C31F9C2_Out_2);
                float2 _Multiply_E6E2F026_Out_2;
                Unity_Multiply_float((_Divide_411EED11_Out_2.xx), _Multiply_9C31F9C2_Out_2, _Multiply_E6E2F026_Out_2);
                float2 _Add_BADC8439_Out_2;
                Unity_Add_float2(_Multiply_39A54641_Out_2, _Multiply_E6E2F026_Out_2, _Add_BADC8439_Out_2);
                float3 _ChannelMask_CFDD80FE_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_BA2C71FD_Out_3, _ChannelMask_CFDD80FE_Out_1);
                float3 _Multiply_A40BA8F9_Out_2;
                Unity_Multiply_float(_ChannelMask_CFDD80FE_Out_1, float3(0.03, 0.03, 0), _Multiply_A40BA8F9_Out_2);
                float2 _Add_6D99D51F_Out_2;
                Unity_Add_float2(_Add_BADC8439_Out_2, (_Multiply_A40BA8F9_Out_2.xy), _Add_6D99D51F_Out_2);
                float4 _SampleTexture2D_D803AB07_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_6D99D51F_Out_2);
                float _SampleTexture2D_D803AB07_R_4 = _SampleTexture2D_D803AB07_RGBA_0.r;
                float _SampleTexture2D_D803AB07_G_5 = _SampleTexture2D_D803AB07_RGBA_0.g;
                float _SampleTexture2D_D803AB07_B_6 = _SampleTexture2D_D803AB07_RGBA_0.b;
                float _SampleTexture2D_D803AB07_A_7 = _SampleTexture2D_D803AB07_RGBA_0.a;
                float _Fraction_F51ED0A1_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_F51ED0A1_Out_1);
                float2 _Multiply_EEA6AA5B_Out_2;
                Unity_Multiply_float(_Branch_EDA2C0E3_Out_3, (_Fraction_F51ED0A1_Out_1.xx), _Multiply_EEA6AA5B_Out_2);
                float2 _Add_9509D7CE_Out_2;
                Unity_Add_float2(_Multiply_E6E2F026_Out_2, _Multiply_EEA6AA5B_Out_2, _Add_9509D7CE_Out_2);
                float2 _Add_3E9F55C4_Out_2;
                Unity_Add_float2(_Add_9509D7CE_Out_2, (_Multiply_A40BA8F9_Out_2.xy), _Add_3E9F55C4_Out_2);
                float4 _SampleTexture2D_198CC76A_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_3E9F55C4_Out_2);
                float _SampleTexture2D_198CC76A_R_4 = _SampleTexture2D_198CC76A_RGBA_0.r;
                float _SampleTexture2D_198CC76A_G_5 = _SampleTexture2D_198CC76A_RGBA_0.g;
                float _SampleTexture2D_198CC76A_B_6 = _SampleTexture2D_198CC76A_RGBA_0.b;
                float _SampleTexture2D_198CC76A_A_7 = _SampleTexture2D_198CC76A_RGBA_0.a;
                float _Lerp_51CEF3BF_Out_3;
                Unity_Lerp_float(_SampleTexture2D_D803AB07_A_7, _SampleTexture2D_198CC76A_A_7, _Absolute_D56AD49D_Out_1, _Lerp_51CEF3BF_Out_3);
                float _Absolute_38E6503D_Out_1;
                Unity_Absolute_float(_Lerp_51CEF3BF_Out_3, _Absolute_38E6503D_Out_1);
                float _Property_C1134212_Out_0 = _SmallCascadeNoisePower;
                float _Power_483D9151_Out_2;
                Unity_Power_float(_Absolute_38E6503D_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                float _Property_8B0E8794_Out_0 = _SmallCascadeNoiseMultiply;
                float _Multiply_E26A26BB_Out_2;
                Unity_Multiply_float(_Power_483D9151_Out_2, _Property_8B0E8794_Out_0, _Multiply_E26A26BB_Out_2);
                float _Clamp_805729EB_Out_3;
                Unity_Clamp_float(_Multiply_E26A26BB_Out_2, 0, 1, _Clamp_805729EB_Out_3);
                float _Lerp_39572874_Out_3;
                Unity_Lerp_float(0, _Blend_A1B262EF_Out_2, _Clamp_805729EB_Out_3, _Lerp_39572874_Out_3);
                float3 _Property_4A612457_Out_0 = _SmallCascadeColor;
                float3 _Multiply_E85EE897_Out_2;
                Unity_Multiply_float((_Lerp_39572874_Out_3.xxx), _Property_4A612457_Out_0, _Multiply_E85EE897_Out_2);
                float _Absolute_5DF2B9D0_Out_1;
                Unity_Absolute_float(_Blend_A1B262EF_Out_2, _Absolute_5DF2B9D0_Out_1);
                float _Property_97A26DCC_Out_0 = _SmallCascadeFoamFalloff;
                float _Power_328AD5E3_Out_2;
                Unity_Power_float(_Absolute_5DF2B9D0_Out_1, _Property_97A26DCC_Out_0, _Power_328AD5E3_Out_2);
                float _Clamp_33692D9C_Out_3;
                Unity_Clamp_float(_Power_328AD5E3_Out_2, 0, 1, _Clamp_33692D9C_Out_3);
                float _Lerp_8877E3D4_Out_3;
                Unity_Lerp_float(0, _Clamp_33692D9C_Out_3, _Clamp_C9BB189_Out_3, _Lerp_8877E3D4_Out_3);
                float3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_float3(_Lerp_6998DF58_Out_3, _Multiply_E85EE897_Out_2, (_Lerp_8877E3D4_Out_3.xxx), _Lerp_4F98523C_Out_3);
                float4 _SampleTexture2D_387AEB22_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascade, sampler_BigCascade, _Add_D29A7CEF_Out_2);
                float _SampleTexture2D_387AEB22_R_4 = _SampleTexture2D_387AEB22_RGBA_0.r;
                float _SampleTexture2D_387AEB22_G_5 = _SampleTexture2D_387AEB22_RGBA_0.g;
                float _SampleTexture2D_387AEB22_B_6 = _SampleTexture2D_387AEB22_RGBA_0.b;
                float _SampleTexture2D_387AEB22_A_7 = _SampleTexture2D_387AEB22_RGBA_0.a;
                float4 _SampleTexture2D_9FEF114B_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascade, sampler_BigCascade, _Add_47CB0CEA_Out_2);
                float _SampleTexture2D_9FEF114B_R_4 = _SampleTexture2D_9FEF114B_RGBA_0.r;
                float _SampleTexture2D_9FEF114B_G_5 = _SampleTexture2D_9FEF114B_RGBA_0.g;
                float _SampleTexture2D_9FEF114B_B_6 = _SampleTexture2D_9FEF114B_RGBA_0.b;
                float _SampleTexture2D_9FEF114B_A_7 = _SampleTexture2D_9FEF114B_RGBA_0.a;
                float _Blend_FAB812B4_Out_2;
                Unity_Blend_Overwrite_float(_SampleTexture2D_387AEB22_A_7, _SampleTexture2D_9FEF114B_A_7, _Blend_FAB812B4_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Multiply_2D163AB3_Out_2;
                Unity_Multiply_float(0.5, _Blend_FAB812B4_Out_2, _Multiply_2D163AB3_Out_2);
                float _Property_5515474F_Out_0 = _BigCascadeNoisePower;
                float _Power_E5773568_Out_2;
                Unity_Power_float(_Absolute_38E6503D_Out_1, _Property_5515474F_Out_0, _Power_E5773568_Out_2);
                float _Property_2C8FB0D9_Out_0 = _BigCascadeNoiseMultiply;
                float _Multiply_9128FAF6_Out_2;
                Unity_Multiply_float(_Power_E5773568_Out_2, _Property_2C8FB0D9_Out_0, _Multiply_9128FAF6_Out_2);
                float _Clamp_1E99CDDE_Out_3;
                Unity_Clamp_float(_Multiply_9128FAF6_Out_2, 0, 1, _Clamp_1E99CDDE_Out_3);
                float _Lerp_50210667_Out_3;
                Unity_Lerp_float(_Multiply_2D163AB3_Out_2, _Blend_FAB812B4_Out_2, _Clamp_1E99CDDE_Out_3, _Lerp_50210667_Out_3);
                float3 _Property_DB02E9C9_Out_0 = _BigCascadeColor;
                float3 _Multiply_630AB59_Out_2;
                Unity_Multiply_float((_Lerp_50210667_Out_3.xxx), _Property_DB02E9C9_Out_0, _Multiply_630AB59_Out_2);
                float _Absolute_E807A97_Out_1;
                Unity_Absolute_float(_Blend_FAB812B4_Out_2, _Absolute_E807A97_Out_1);
                float _Property_97864BE9_Out_0 = Big_Cascade_Foam_Falloff;
                float _Power_F37DBF08_Out_2;
                Unity_Power_float(_Absolute_E807A97_Out_1, _Property_97864BE9_Out_0, _Power_F37DBF08_Out_2);
                float _Clamp_142C06F9_Out_3;
                Unity_Clamp_float(_Power_F37DBF08_Out_2, 0, 1, _Clamp_142C06F9_Out_3);
                float _Lerp_6316FED8_Out_3;
                Unity_Lerp_float(0, _Clamp_142C06F9_Out_3, _Clamp_C3D0E6D0_Out_3, _Lerp_6316FED8_Out_3);
                float3 _Lerp_96C773B7_Out_3;
                Unity_Lerp_float3(_Lerp_4F98523C_Out_3, _Multiply_630AB59_Out_2, (_Lerp_6316FED8_Out_3.xxx), _Lerp_96C773B7_Out_3);
                float3 _Lerp_8DC18263_Out_3;
                Unity_Lerp_float3(_Lerp_96C773B7_Out_3, _Lerp_DF8F6DB6_Out_3, (_Split_42E433A0_R_1.xxx), _Lerp_8DC18263_Out_3);
                float3 _Lerp_39AFE3C2_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Multiply_E85EE897_Out_2, (_Clamp_33692D9C_Out_3.xxx), _Lerp_39AFE3C2_Out_3);
                float3 _Lerp_78BD1AA8_Out_3;
                Unity_Lerp_float3(_Lerp_8DC18263_Out_3, _Lerp_39AFE3C2_Out_3, (_Split_42E433A0_G_2.xxx), _Lerp_78BD1AA8_Out_3);
                float3 _Lerp_8E1AA6D9_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Multiply_630AB59_Out_2, (_Clamp_142C06F9_Out_3.xxx), _Lerp_8E1AA6D9_Out_3);
                float3 _Lerp_EE19DF0F_Out_3;
                Unity_Lerp_float3(_Lerp_78BD1AA8_Out_3, _Lerp_8E1AA6D9_Out_3, (_Split_42E433A0_B_3.xxx), _Lerp_EE19DF0F_Out_3);
                float _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                float _Property_44A9A39E_Out_0 = _EdgeFalloffMultiply;
                float _Multiply_943A3DD9_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_44A9A39E_Out_0, _Multiply_943A3DD9_Out_2);
                float _Clamp_16BD4100_Out_3;
                Unity_Clamp_float(_Multiply_943A3DD9_Out_2, 0, 1, _Clamp_16BD4100_Out_3);
                float _Absolute_1003CC59_Out_1;
                Unity_Absolute_float(_Clamp_16BD4100_Out_3, _Absolute_1003CC59_Out_1);
                float _Property_3A9F02A2_Out_0 = _EdgeFalloffPower;
                float _Power_54D889D2_Out_2;
                Unity_Power_float(_Absolute_1003CC59_Out_1, _Property_3A9F02A2_Out_0, _Power_54D889D2_Out_2);
                float _Clamp_A8945B73_Out_3;
                Unity_Clamp_float(_Power_54D889D2_Out_2, 0, 1, _Clamp_A8945B73_Out_3);
                float _Multiply_73E319C1_Out_2;
                Unity_Multiply_float(_Clamp_A8945B73_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                float _Property_6C82272C_Out_0 = _BackfaceAlpha;
                float _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_float(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                float _Branch_6D78BA69_Out_3;
                Unity_Branch_float(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                surface.Albedo = _Lerp_EE19DF0F_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                float4 uv3 : TEXCOORD3;
                float4 color : COLOR;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS;
                float3 normalWS;
                float4 tangentWS;
                float4 texCoord0;
                float4 texCoord3;
                float4 color;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float3 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
                float4 interp03 : TEXCOORD3;
                float4 interp04 : TEXCOORD4;
                float4 interp05 : TEXCOORD5;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord3;
                output.interp05.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord3 = input.interp04.xyzw;
                output.color = input.interp05.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                output.uv0 =                         input.uv0;
                output.uv3 =                         input.uv3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            	float3 unnormalizedNormalWS = input.normalWS;
                const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            
            	// use bitangent on the fly like in hdrp
            	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
            	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
            
                output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            
            	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
            	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
            	output.WorldSpaceBiTangent =         renormFactor*bitang;
            
                output.WorldSpacePosition =          input.positionWS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                output.uv0 =                         input.texCoord0;
                output.uv3 =                         input.texCoord3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
                BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            // Name: <None>
            Tags 
            { 
                "LightMode" = "Universal2D"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>
            
            // Defines
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define _NORMALMAP 1
            #define _SPECULAR_SETUP
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS 
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_CULLFACE
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_2D
            #define REQUIRE_DEPTH_TEXTURE
            #define REQUIRE_OPAQUE_TEXTURE
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float _GlobalTiling;
            float _UVVDirection1UDirection0;
            float2 _SlowWaterSpeed;
            float2 _SlowWaterMixSpeed;
            float2 _SmallCascadeMainSpeed;
            float2 _BigCascadeMainSpeed;
            float _EdgeFalloffMultiply;
            float _EdgeFalloffPower;
            float _CleanFalloffMultiply;
            float _CleanFalloffPower;
            float4 _ShalowColor;
            float _ShalowFalloffMultiply;
            float _ShalowFalloffPower;
            float4 _DeepColor;
            float _WaterAlphaMultiply;
            float _WaterAlphaPower;
            float _WaveTranslucencyFallOffDistance;
            float _WaveTranslucencyPower;
            float _WaveTranslucencyHardness;
            float _WaveTranslucencyMultiply;
            float _SlowWaterTranslucencyMultiply;
            float _SmallCascadeTranslucencyMultiply;
            float _BigCascadeTranslucencyMultiply;
            float _WaterSmoothness;
            float _WaterSpecularClose;
            float _WaterSpecularFar;
            float _WaterSpecularThreshold;
            float _Distortion;
            float _BackfaceAlpha;
            float _MicroWaveNormalScale;
            float2 _MicroWaveTiling;
            float _MacroWaveNormalScale;
            float2 _MacroWaveTiling;
            float2 _SlowWaterTiling;
            float _SlowNormalScale;
            float _FarNormalPower;
            float _FarNormalBlendStartDistance;
            float _FarNormalBlendThreshold;
            float _SmallCascadeAngle;
            float _SmallCascadeAngleFalloff;
            float2 _SmallCascadeTiling;
            float _SmallCascadeNormalScale;
            float3 _SmallCascadeColor;
            float _SmallCascadeFoamFalloff;
            float _SmallCascadeSmoothness;
            float _SmallCascadeSpecular;
            float _BigCascadeAngle;
            float _BigCascadeAngleFalloff;
            float _BigCascadeNormalScale;
            float2 _BigCascadeTiling;
            float3 _BigCascadeColor;
            float Big_Cascade_Foam_Falloff;
            float _BigCascadeTransparency;
            float _BigCascadeSmoothness;
            float _BigCascadeSpecular;
            float _SlowWaterTessScale;
            float MacroWaveTessScale;
            float _SmallCascadeWaterTessScale;
            float _BigCascadeWaterTessScale;
            float _SmallCascadeNoisePower;
            float _BigCascadeNoisePower;
            float _SmallCascadeNoiseMultiply;
            float _BigCascadeNoiseMultiply;
            float2 _FoamTiling;
            float2 _FoamSpeed;
            float3 _FoamColor;
            float _FoamDepth;
            float _FoamFalloff;
            float _FoamWaveHardness;
            float _FoamWavePower;
            float _FoamWaveMultiply;
            float _FoamSmoothness;
            float _FoamSpecular;
            float2 _NoiseTiling;
            float2 _NoiseSpeed;
            float _AOPower;
            float _WaterFlowUVRefresSpeed;
            float _SmallCascadeFlowUVRefreshSpeed;
            float _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); float4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_SmallCascadeNormal); SAMPLER(sampler_SmallCascadeNormal); float4 _SmallCascadeNormal_TexelSize;
            TEXTURE2D(_SmallCascade); SAMPLER(sampler_SmallCascade); float4 _SmallCascade_TexelSize;
            TEXTURE2D(_BigCascadeNormal); SAMPLER(sampler_BigCascadeNormal); float4 _BigCascadeNormal_TexelSize;
            TEXTURE2D(_BigCascade); SAMPLER(sampler_BigCascade); float4 _BigCascade_TexelSize;
            TEXTURE2D(_SlowWaterTesselation); SAMPLER(sampler_SlowWaterTesselation); float4 _SlowWaterTesselation_TexelSize;
            TEXTURE2D(_SmallCascadeWaterTess); SAMPLER(sampler_SmallCascadeWaterTess); float4 _SmallCascadeWaterTess_TexelSize;
            TEXTURE2D(BigCascadeWaterTess); SAMPLER(samplerBigCascadeWaterTess); float4 BigCascadeWaterTess_TexelSize;
            TEXTURE2D(_Foam); SAMPLER(sampler_Foam); float4 _Foam_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); float4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2DLOD_35997DE_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F6D4A02B_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_CABCD0D0_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_2BB41D12_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_F0E303B2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_27B55B65_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2DLOD_4648E9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_F765A3FA_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_49A71497_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6ABE710E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6FC3A421_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_13F501DC_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_C713F57F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_5CD91024_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_28CB720F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_8FF1FC6F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_3D04E744_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_FDC3D2E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D6FF940D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_80481243_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D803AB07_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_198CC76A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_387AEB22_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9FEF114B_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Fraction_float(float In, out float Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
            {
                Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_ChannelMask_RedGreen_float3 (float3 In, out float3 Out)
            {
                Out = float3(In.r, In.g, 0);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Normalize_float3(float3 In, out float3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Distance_float3(float3 A, float3 B, out float Out)
            {
                Out = distance(A, B);
            }
            
            void Unity_SceneColor_float(float4 UV, out float3 Out)
            {
                Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
            }
            
            void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Blend_Overwrite_float(float Base, float Blend, out float Out, float Opacity)
            {
                Out = lerp(Base, Blend, Opacity);
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 WorldSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
            };
            
            struct VertexDescription
            {
                float3 VertexPosition;
                float3 VertexNormal;
                float3 VertexTangent;
            };
            
            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float4 _SampleTexture2DLOD_35997DE_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_4ECADB09_Out_2, 0);
                float _SampleTexture2DLOD_35997DE_R_5 = _SampleTexture2DLOD_35997DE_RGBA_0.r;
                float _SampleTexture2DLOD_35997DE_G_6 = _SampleTexture2DLOD_35997DE_RGBA_0.g;
                float _SampleTexture2DLOD_35997DE_B_7 = _SampleTexture2DLOD_35997DE_RGBA_0.b;
                float _SampleTexture2DLOD_35997DE_A_8 = _SampleTexture2DLOD_35997DE_RGBA_0.a;
                float _Add_92BD554B_Out_2;
                Unity_Add_float(_SampleTexture2DLOD_35997DE_A_8, -0.25, _Add_92BD554B_Out_2);
                float _Property_6AEE6AD6_Out_0 = MacroWaveTessScale;
                float _Multiply_B04BDAD0_Out_2;
                Unity_Multiply_float(_Add_92BD554B_Out_2, _Property_6AEE6AD6_Out_0, _Multiply_B04BDAD0_Out_2);
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_FE512398_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_FE512398_Out_2);
                float4 _SampleTexture2DLOD_F6D4A02B_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_FE512398_Out_2, 0);
                float _SampleTexture2DLOD_F6D4A02B_R_5 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.r;
                float _SampleTexture2DLOD_F6D4A02B_G_6 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.g;
                float _SampleTexture2DLOD_F6D4A02B_B_7 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.b;
                float _SampleTexture2DLOD_F6D4A02B_A_8 = _SampleTexture2DLOD_F6D4A02B_RGBA_0.a;
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_3D189493_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_3D189493_Out_2);
                float4 _SampleTexture2DLOD_CABCD0D0_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_3D189493_Out_2, 0);
                float _SampleTexture2DLOD_CABCD0D0_R_5 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.r;
                float _SampleTexture2DLOD_CABCD0D0_G_6 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.g;
                float _SampleTexture2DLOD_CABCD0D0_B_7 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.b;
                float _SampleTexture2DLOD_CABCD0D0_A_8 = _SampleTexture2DLOD_CABCD0D0_RGBA_0.a;
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_B4922E7C_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_B4922E7C_Out_1);
                float _Lerp_DEF9BA7B_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_F6D4A02B_A_8, _SampleTexture2DLOD_CABCD0D0_A_8, _Absolute_B4922E7C_Out_1, _Lerp_DEF9BA7B_Out_3);
                float _Add_E7355D81_Out_2;
                Unity_Add_float(_Lerp_DEF9BA7B_Out_3, -0.25, _Add_E7355D81_Out_2);
                float _Property_57308837_Out_0 = _SlowWaterTessScale;
                float _Multiply_146A3378_Out_2;
                Unity_Multiply_float(_Add_E7355D81_Out_2, _Property_57308837_Out_0, _Multiply_146A3378_Out_2);
                float _Add_42AED159_Out_2;
                Unity_Add_float(_Multiply_B04BDAD0_Out_2, _Multiply_146A3378_Out_2, _Add_42AED159_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_C675255A_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_C675255A_Out_2);
                float4 _SampleTexture2DLOD_2BB41D12_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_C675255A_Out_2, 0);
                float _SampleTexture2DLOD_2BB41D12_R_5 = _SampleTexture2DLOD_2BB41D12_RGBA_0.r;
                float _SampleTexture2DLOD_2BB41D12_G_6 = _SampleTexture2DLOD_2BB41D12_RGBA_0.g;
                float _SampleTexture2DLOD_2BB41D12_B_7 = _SampleTexture2DLOD_2BB41D12_RGBA_0.b;
                float _SampleTexture2DLOD_2BB41D12_A_8 = _SampleTexture2DLOD_2BB41D12_RGBA_0.a;
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_89DE95D0_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_89DE95D0_Out_2);
                float4 _SampleTexture2DLOD_F0E303B2_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_89DE95D0_Out_2, 0);
                float _SampleTexture2DLOD_F0E303B2_R_5 = _SampleTexture2DLOD_F0E303B2_RGBA_0.r;
                float _SampleTexture2DLOD_F0E303B2_G_6 = _SampleTexture2DLOD_F0E303B2_RGBA_0.g;
                float _SampleTexture2DLOD_F0E303B2_B_7 = _SampleTexture2DLOD_F0E303B2_RGBA_0.b;
                float _SampleTexture2DLOD_F0E303B2_A_8 = _SampleTexture2DLOD_F0E303B2_RGBA_0.a;
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float _Lerp_4F958902_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_2BB41D12_A_8, _SampleTexture2DLOD_F0E303B2_A_8, _Absolute_D56AD49D_Out_1, _Lerp_4F958902_Out_3);
                float _Add_4C244952_Out_2;
                Unity_Add_float(_Lerp_4F958902_Out_3, -0.25, _Add_4C244952_Out_2);
                float _Property_A41EED02_Out_0 = _SmallCascadeWaterTessScale;
                float _Multiply_C6FA813B_Out_2;
                Unity_Multiply_float(_Add_4C244952_Out_2, _Property_A41EED02_Out_0, _Multiply_C6FA813B_Out_2);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float _Multiply_97C7958D_Out_2;
                Unity_Multiply_float(_Multiply_C6FA813B_Out_2, _Clamp_C9BB189_Out_3, _Multiply_97C7958D_Out_2);
                float _Add_B8D97A66_Out_2;
                Unity_Add_float(_Add_42AED159_Out_2, _Multiply_97C7958D_Out_2, _Add_B8D97A66_Out_2);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_260C289D_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_260C289D_Out_2);
                float4 _SampleTexture2DLOD_27B55B65_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_260C289D_Out_2, 0);
                float _SampleTexture2DLOD_27B55B65_R_5 = _SampleTexture2DLOD_27B55B65_RGBA_0.r;
                float _SampleTexture2DLOD_27B55B65_G_6 = _SampleTexture2DLOD_27B55B65_RGBA_0.g;
                float _SampleTexture2DLOD_27B55B65_B_7 = _SampleTexture2DLOD_27B55B65_RGBA_0.b;
                float _SampleTexture2DLOD_27B55B65_A_8 = _SampleTexture2DLOD_27B55B65_RGBA_0.a;
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_672C60ED_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_672C60ED_Out_2);
                float4 _SampleTexture2DLOD_4648E9_RGBA_0 = SAMPLE_TEXTURE2D_LOD(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_672C60ED_Out_2, 0);
                float _SampleTexture2DLOD_4648E9_R_5 = _SampleTexture2DLOD_4648E9_RGBA_0.r;
                float _SampleTexture2DLOD_4648E9_G_6 = _SampleTexture2DLOD_4648E9_RGBA_0.g;
                float _SampleTexture2DLOD_4648E9_B_7 = _SampleTexture2DLOD_4648E9_RGBA_0.b;
                float _SampleTexture2DLOD_4648E9_A_8 = _SampleTexture2DLOD_4648E9_RGBA_0.a;
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Lerp_1934036C_Out_3;
                Unity_Lerp_float(_SampleTexture2DLOD_27B55B65_A_8, _SampleTexture2DLOD_4648E9_A_8, _Absolute_19D4C5A5_Out_1, _Lerp_1934036C_Out_3);
                float _Add_5F941B40_Out_2;
                Unity_Add_float(_Lerp_1934036C_Out_3, -0.25, _Add_5F941B40_Out_2);
                float _Property_D14DBA62_Out_0 = _BigCascadeWaterTessScale;
                float _Multiply_131F4390_Out_2;
                Unity_Multiply_float(_Add_5F941B40_Out_2, _Property_D14DBA62_Out_0, _Multiply_131F4390_Out_2);
                float _Multiply_F5B5CD1C_Out_2;
                Unity_Multiply_float(_Multiply_131F4390_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_F5B5CD1C_Out_2);
                float _Add_2878DA0E_Out_2;
                Unity_Add_float(_Add_B8D97A66_Out_2, _Multiply_F5B5CD1C_Out_2, _Add_2878DA0E_Out_2);
                float _Split_28662C1C_R_1 = IN.VertexColor[0];
                float _Split_28662C1C_G_2 = IN.VertexColor[1];
                float _Split_28662C1C_B_3 = IN.VertexColor[2];
                float _Split_28662C1C_A_4 = IN.VertexColor[3];
                float _Lerp_A69B24EB_Out_3;
                Unity_Lerp_float(_Add_2878DA0E_Out_2, _Add_42AED159_Out_2, _Split_28662C1C_R_1, _Lerp_A69B24EB_Out_3);
                float _Lerp_B24A0C56_Out_3;
                Unity_Lerp_float(_Lerp_A69B24EB_Out_3, _Multiply_97C7958D_Out_2, _Split_28662C1C_G_2, _Lerp_B24A0C56_Out_3);
                float _Lerp_5C765D8_Out_3;
                Unity_Lerp_float(_Lerp_B24A0C56_Out_3, _Multiply_131F4390_Out_2, _Split_28662C1C_B_3, _Lerp_5C765D8_Out_3);
                float3 _Multiply_238083B9_Out_2;
                Unity_Multiply_float(IN.ObjectSpaceNormal, (_Lerp_5C765D8_Out_3.xxx), _Multiply_238083B9_Out_2);
                float3 _Add_8A04BBE9_Out_2;
                Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_238083B9_Out_2, _Add_8A04BBE9_Out_2);
                description.VertexPosition = _Add_8A04BBE9_Out_2;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 WorldSpacePosition;
                float3 AbsoluteWorldSpacePosition;
                float4 ScreenPosition;
                float4 uv0;
                float4 uv3;
                float4 VertexColor;
                float3 TimeParameters;
                float FaceSign;
            };
            
            struct SurfaceDescription
            {
                float3 Albedo;
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float4 _ScreenPosition_1B148032_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _Property_FC343CDD_Out_0 = _Distortion;
                float _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                float2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                float2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_float(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                float4 _UV_AA9F78F6_Out_0 = IN.uv3;
                float2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_float(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                float _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                float _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                float _Split_1CCC86B0_B_3 = 0;
                float _Split_1CCC86B0_A_4 = 0;
                float2 _Vector2_D812D559_Out_0 = float2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                float2 _Branch_FA6538E6_Out_3;
                Unity_Branch_float2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                float _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                float _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                float _Add_41D6C6C9_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                float _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_float(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                float2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                float _Property_52173963_Out_0 = _GlobalTiling;
                float _Divide_654AFB32_Out_2;
                Unity_Divide_float(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                float4 _UV_B5F91807_Out_0 = IN.uv0;
                float2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_float(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                float2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_float((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                float2 _Add_7772C3BA_Out_2;
                Unity_Add_float2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_7772C3BA_Out_2);
                float4 _SampleTexture2D_91308B7C_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_7772C3BA_Out_2);
                _SampleTexture2D_91308B7C_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_91308B7C_RGBA_0);
                float _SampleTexture2D_91308B7C_R_4 = _SampleTexture2D_91308B7C_RGBA_0.r;
                float _SampleTexture2D_91308B7C_G_5 = _SampleTexture2D_91308B7C_RGBA_0.g;
                float _SampleTexture2D_91308B7C_B_6 = _SampleTexture2D_91308B7C_RGBA_0.b;
                float _SampleTexture2D_91308B7C_A_7 = _SampleTexture2D_91308B7C_RGBA_0.a;
                float _Property_BE91B4F6_Out_0 = _SlowNormalScale;
                float3 _NormalStrength_528ACD86_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_91308B7C_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_528ACD86_Out_2);
                float _Add_31890938_Out_2;
                Unity_Add_float(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                float _Fraction_F03C9359_Out_1;
                Unity_Fraction_float(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                float2 _Multiply_FE081078_Out_2;
                Unity_Multiply_float(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                float2 _Add_C1F18389_Out_2;
                Unity_Add_float2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_C1F18389_Out_2);
                float4 _SampleTexture2D_4508A259_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_C1F18389_Out_2);
                _SampleTexture2D_4508A259_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_4508A259_RGBA_0);
                float _SampleTexture2D_4508A259_R_4 = _SampleTexture2D_4508A259_RGBA_0.r;
                float _SampleTexture2D_4508A259_G_5 = _SampleTexture2D_4508A259_RGBA_0.g;
                float _SampleTexture2D_4508A259_B_6 = _SampleTexture2D_4508A259_RGBA_0.b;
                float _SampleTexture2D_4508A259_A_7 = _SampleTexture2D_4508A259_RGBA_0.a;
                float3 _NormalStrength_3BD81F5D_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_4508A259_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_3BD81F5D_Out_2);
                float _Add_9431F443_Out_2;
                Unity_Add_float(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                float _Multiply_483E3720_Out_2;
                Unity_Multiply_float(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                float _Absolute_6685A82A_Out_1;
                Unity_Absolute_float(_Multiply_483E3720_Out_2, _Absolute_6685A82A_Out_1);
                float3 _Lerp_356E067F_Out_3;
                Unity_Lerp_float3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                float _Split_D8BC109F_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_D8BC109F_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_D8BC109F_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_D8BC109F_A_4 = 0;
                float4 _Combine_1C01E76C_RGBA_4;
                float3 _Combine_1C01E76C_RGB_5;
                float2 _Combine_1C01E76C_RG_6;
                Unity_Combine_float(_Split_D8BC109F_R_1, _Split_D8BC109F_B_3, 0, 0, _Combine_1C01E76C_RGBA_4, _Combine_1C01E76C_RGB_5, _Combine_1C01E76C_RG_6);
                float2 _Property_6D8A3257_Out_0 = _MicroWaveTiling;
                float _Property_AA95233A_Out_0 = _GlobalTiling;
                float2 _Multiply_ABD9AE79_Out_2;
                Unity_Multiply_float(_Property_6D8A3257_Out_0, (_Property_AA95233A_Out_0.xx), _Multiply_ABD9AE79_Out_2);
                float2 _Divide_9BA6D0A0_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_ABD9AE79_Out_2, _Divide_9BA6D0A0_Out_2);
                float2 _Multiply_9E511F45_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_9BA6D0A0_Out_2, _Multiply_9E511F45_Out_2);
                float2 _Property_EF89141C_Out_0 = _SlowWaterMixSpeed;
                float2 _Multiply_EA842EC4_Out_2;
                Unity_Multiply_float((IN.TimeParameters.x.xx), _Property_EF89141C_Out_0, _Multiply_EA842EC4_Out_2);
                float2 _Add_4F7464A_Out_2;
                Unity_Add_float2(_Multiply_9E511F45_Out_2, _Multiply_EA842EC4_Out_2, _Add_4F7464A_Out_2);
                float3 _ChannelMask_1D6B2B0B_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_356E067F_Out_3, _ChannelMask_1D6B2B0B_Out_1);
                float3 _Multiply_9233494E_Out_2;
                Unity_Multiply_float(_ChannelMask_1D6B2B0B_Out_1, float3(0.05, 0.05, 0), _Multiply_9233494E_Out_2);
                float2 _Add_3A640853_Out_2;
                Unity_Add_float2(_Add_4F7464A_Out_2, (_Multiply_9233494E_Out_2.xy), _Add_3A640853_Out_2);
                float4 _SampleTexture2D_F765A3FA_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_3A640853_Out_2);
                _SampleTexture2D_F765A3FA_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_F765A3FA_RGBA_0);
                float _SampleTexture2D_F765A3FA_R_4 = _SampleTexture2D_F765A3FA_RGBA_0.r;
                float _SampleTexture2D_F765A3FA_G_5 = _SampleTexture2D_F765A3FA_RGBA_0.g;
                float _SampleTexture2D_F765A3FA_B_6 = _SampleTexture2D_F765A3FA_RGBA_0.b;
                float _SampleTexture2D_F765A3FA_A_7 = _SampleTexture2D_F765A3FA_RGBA_0.a;
                float2 _Vector2_70672A35_Out_0 = float2(_SampleTexture2D_F765A3FA_R_4, _SampleTexture2D_F765A3FA_G_5);
                float3 _Sign_A4C02BB9_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_A4C02BB9_Out_1);
                float _Split_10A45667_R_1 = _Sign_A4C02BB9_Out_1[0];
                float _Split_10A45667_G_2 = _Sign_A4C02BB9_Out_1[1];
                float _Split_10A45667_B_3 = _Sign_A4C02BB9_Out_1[2];
                float _Split_10A45667_A_4 = 0;
                float2 _Vector2_C260D6C2_Out_0 = float2(_Split_10A45667_G_2, 1);
                float2 _Multiply_D4982FB9_Out_2;
                Unity_Multiply_float(_Vector2_70672A35_Out_0, _Vector2_C260D6C2_Out_0, _Multiply_D4982FB9_Out_2);
                float _Split_DCB9F46D_R_1 = IN.WorldSpaceNormal[0];
                float _Split_DCB9F46D_G_2 = IN.WorldSpaceNormal[1];
                float _Split_DCB9F46D_B_3 = IN.WorldSpaceNormal[2];
                float _Split_DCB9F46D_A_4 = 0;
                float2 _Vector2_8F37EEDE_Out_0 = float2(_Split_DCB9F46D_R_1, _Split_DCB9F46D_B_3);
                float2 _Add_EDD61406_Out_2;
                Unity_Add_float2(_Multiply_D4982FB9_Out_2, _Vector2_8F37EEDE_Out_0, _Add_EDD61406_Out_2);
                float _Split_DBEE69C5_R_1 = _Add_EDD61406_Out_2[0];
                float _Split_DBEE69C5_G_2 = _Add_EDD61406_Out_2[1];
                float _Split_DBEE69C5_B_3 = 0;
                float _Split_DBEE69C5_A_4 = 0;
                float _Multiply_19C907AA_Out_2;
                Unity_Multiply_float(_SampleTexture2D_F765A3FA_B_6, _Split_DCB9F46D_G_2, _Multiply_19C907AA_Out_2);
                float3 _Vector3_CC599D5F_Out_0 = float3(_Split_DBEE69C5_R_1, _Multiply_19C907AA_Out_2, _Split_DBEE69C5_G_2);
                float3x3 Transform_E097B73C_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_E097B73C_Out_1 = TransformWorldToTangent(_Vector3_CC599D5F_Out_0.xyz, Transform_E097B73C_tangentTransform_World);
                float3 _Normalize_6560E7A8_Out_1;
                Unity_Normalize_float3(_Transform_E097B73C_Out_1, _Normalize_6560E7A8_Out_1);
                float _Property_7246E682_Out_0 = _MicroWaveNormalScale;
                float3 _NormalStrength_E984BDF9_Out_2;
                Unity_NormalStrength_float(_Normalize_6560E7A8_Out_1, _Property_7246E682_Out_0, _NormalStrength_E984BDF9_Out_2);
                float2 _Property_478D8D41_Out_0 = _MacroWaveTiling;
                float2 _Multiply_467FF9ED_Out_2;
                Unity_Multiply_float((_Property_AA95233A_Out_0.xx), _Property_478D8D41_Out_0, _Multiply_467FF9ED_Out_2);
                float2 _Divide_CBA7F1F6_Out_2;
                Unity_Divide_float2(float2(1, 1), _Multiply_467FF9ED_Out_2, _Divide_CBA7F1F6_Out_2);
                float2 _Multiply_47065C63_Out_2;
                Unity_Multiply_float((_Combine_1C01E76C_RGBA_4.xy), _Divide_CBA7F1F6_Out_2, _Multiply_47065C63_Out_2);
                float2 _Add_4ECADB09_Out_2;
                Unity_Add_float2(_Multiply_EA842EC4_Out_2, _Multiply_47065C63_Out_2, _Add_4ECADB09_Out_2);
                float2 _Add_B51BFC_Out_2;
                Unity_Add_float2(_Add_4ECADB09_Out_2, (_Multiply_9233494E_Out_2.xy), _Add_B51BFC_Out_2);
                float4 _SampleTexture2D_49A71497_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_B51BFC_Out_2);
                _SampleTexture2D_49A71497_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_49A71497_RGBA_0);
                float _SampleTexture2D_49A71497_R_4 = _SampleTexture2D_49A71497_RGBA_0.r;
                float _SampleTexture2D_49A71497_G_5 = _SampleTexture2D_49A71497_RGBA_0.g;
                float _SampleTexture2D_49A71497_B_6 = _SampleTexture2D_49A71497_RGBA_0.b;
                float _SampleTexture2D_49A71497_A_7 = _SampleTexture2D_49A71497_RGBA_0.a;
                float2 _Vector2_EE92CBEE_Out_0 = float2(_SampleTexture2D_49A71497_R_4, _SampleTexture2D_49A71497_G_5);
                float3 _Sign_CE4A6EE0_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_CE4A6EE0_Out_1);
                float _Split_717E3A76_R_1 = _Sign_CE4A6EE0_Out_1[0];
                float _Split_717E3A76_G_2 = _Sign_CE4A6EE0_Out_1[1];
                float _Split_717E3A76_B_3 = _Sign_CE4A6EE0_Out_1[2];
                float _Split_717E3A76_A_4 = 0;
                float2 _Vector2_43391560_Out_0 = float2(_Split_717E3A76_G_2, 1);
                float2 _Multiply_4D74E9F7_Out_2;
                Unity_Multiply_float(_Vector2_EE92CBEE_Out_0, _Vector2_43391560_Out_0, _Multiply_4D74E9F7_Out_2);
                float _Split_1E9BE17E_R_1 = IN.WorldSpaceNormal[0];
                float _Split_1E9BE17E_G_2 = IN.WorldSpaceNormal[1];
                float _Split_1E9BE17E_B_3 = IN.WorldSpaceNormal[2];
                float _Split_1E9BE17E_A_4 = 0;
                float2 _Vector2_7FB5264B_Out_0 = float2(_Split_1E9BE17E_R_1, _Split_1E9BE17E_B_3);
                float2 _Add_398D7267_Out_2;
                Unity_Add_float2(_Multiply_4D74E9F7_Out_2, _Vector2_7FB5264B_Out_0, _Add_398D7267_Out_2);
                float _Split_5414ACAC_R_1 = _Add_398D7267_Out_2[0];
                float _Split_5414ACAC_G_2 = _Add_398D7267_Out_2[1];
                float _Split_5414ACAC_B_3 = 0;
                float _Split_5414ACAC_A_4 = 0;
                float _Multiply_80133872_Out_2;
                Unity_Multiply_float(_SampleTexture2D_49A71497_B_6, _Split_1E9BE17E_G_2, _Multiply_80133872_Out_2);
                float3 _Vector3_336A482E_Out_0 = float3(_Split_5414ACAC_R_1, _Multiply_80133872_Out_2, _Split_5414ACAC_G_2);
                float3x3 Transform_5FC79949_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_5FC79949_Out_1 = TransformWorldToTangent(_Vector3_336A482E_Out_0.xyz, Transform_5FC79949_tangentTransform_World);
                float3 _Normalize_F8AB1C98_Out_1;
                Unity_Normalize_float3(_Transform_5FC79949_Out_1, _Normalize_F8AB1C98_Out_1);
                float _Property_EE02697B_Out_0 = _MacroWaveNormalScale;
                float3 _NormalStrength_3E2CC83C_Out_2;
                Unity_NormalStrength_float(_Normalize_F8AB1C98_Out_1, _Property_EE02697B_Out_0, _NormalStrength_3E2CC83C_Out_2);
                float3 _NormalBlend_942EAE7_Out_2;
                Unity_NormalBlend_float(_NormalStrength_E984BDF9_Out_2, _NormalStrength_3E2CC83C_Out_2, _NormalBlend_942EAE7_Out_2);
                float3 _NormalBlend_412E2B77_Out_2;
                Unity_NormalBlend_float(_Lerp_356E067F_Out_3, _NormalBlend_942EAE7_Out_2, _NormalBlend_412E2B77_Out_2);
                float _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                float2 _Property_87340130_Out_0 = _SmallCascadeTiling;
                float2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_float(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                float4 _UV_106B410B_Out_0 = IN.uv3;
                float2 _Multiply_A639E196_Out_2;
                Unity_Multiply_float(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                float _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                float _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                float _Split_D288CE58_B_3 = 0;
                float _Split_D288CE58_A_4 = 0;
                float2 _Vector2_76C74260_Out_0 = float2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                float2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_float2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                float _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
                float _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                float _Add_7EF542FE_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                float _Fraction_5582502D_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                float2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                float _Property_506342C2_Out_0 = _GlobalTiling;
                float _Divide_E07C316A_Out_2;
                Unity_Divide_float(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                float4 _UV_BEAE142D_Out_0 = IN.uv0;
                float2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_float(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                float2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_float((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                float2 _Add_188C8FD3_Out_2;
                Unity_Add_float2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_188C8FD3_Out_2);
                float4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeNormal, sampler_SmallCascadeNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                float _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                float _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                float _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                float _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                float _Property_8A81F679_Out_0 = _SmallCascadeNormalScale;
                float3 _NormalStrength_94FC33DB_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_AEBC8292_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_94FC33DB_Out_2);
                float _Add_42A4AEEC_Out_2;
                Unity_Add_float(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                float _Fraction_3662A9DE_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                float2 _Multiply_283B3646_Out_2;
                Unity_Multiply_float(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                float2 _Add_3E5AC13E_Out_2;
                Unity_Add_float2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_3E5AC13E_Out_2);
                float4 _SampleTexture2D_9126225F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeNormal, sampler_SmallCascadeNormal, _Add_3E5AC13E_Out_2);
                _SampleTexture2D_9126225F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9126225F_RGBA_0);
                float _SampleTexture2D_9126225F_R_4 = _SampleTexture2D_9126225F_RGBA_0.r;
                float _SampleTexture2D_9126225F_G_5 = _SampleTexture2D_9126225F_RGBA_0.g;
                float _SampleTexture2D_9126225F_B_6 = _SampleTexture2D_9126225F_RGBA_0.b;
                float _SampleTexture2D_9126225F_A_7 = _SampleTexture2D_9126225F_RGBA_0.a;
                float3 _NormalStrength_337B983B_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_9126225F_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_337B983B_Out_2);
                float _Add_1044203D_Out_2;
                Unity_Add_float(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                float _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_float(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                float _Absolute_D56AD49D_Out_1;
                Unity_Absolute_float(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                float3 _Lerp_5B898C96_Out_3;
                Unity_Lerp_float3(_NormalStrength_94FC33DB_Out_2, _NormalStrength_337B983B_Out_2, (_Absolute_D56AD49D_Out_1.xxx), _Lerp_5B898C96_Out_3);
                float _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                float _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                float _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                float _Split_C4B2F888_A_4 = 0;
                float _Absolute_5691484_Out_1;
                Unity_Absolute_float(_Split_C4B2F888_G_2, _Absolute_5691484_Out_1);
                float _Clamp_7DFFA574_Out_3;
                Unity_Clamp_float(_Absolute_5691484_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                float _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
                float _Divide_3235AB33_Out_2;
                Unity_Divide_float(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                float _OneMinus_57DB513_Out_1;
                Unity_OneMinus_float(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                float _Subtract_B782DE16_Out_2;
                Unity_Subtract_float(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                float _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_float(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                float _Divide_BD74F0DD_Out_2;
                Unity_Divide_float(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                float _Multiply_A56B78D9_Out_2;
                Unity_Multiply_float(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                float _Clamp_368478F5_Out_3;
                Unity_Clamp_float(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                float _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_float(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                float _Absolute_438A66D_Out_1;
                Unity_Absolute_float(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                float _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                float _Power_A86AE25B_Out_2;
                Unity_Power_float(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                float _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                float _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                float _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                float _Split_7AAAB3D7_A_4 = 0;
                float _Absolute_25C8BD89_Out_1;
                Unity_Absolute_float(_Split_7AAAB3D7_G_2, _Absolute_25C8BD89_Out_1);
                float _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_float(_Absolute_25C8BD89_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                float _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                float _Divide_EAB4CFE5_Out_2;
                Unity_Divide_float(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                float _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_float(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                float _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_float(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                float _Clamp_F34F3E95_Out_3;
                Unity_Clamp_float(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                float _Divide_2BCCE84_Out_2;
                Unity_Divide_float(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                float _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_float(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                float _Clamp_C5CAE82_Out_3;
                Unity_Clamp_float(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                float _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_float(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                float _Absolute_19F078F3_Out_1;
                Unity_Absolute_float(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                float _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                float _Power_8825055A_Out_2;
                Unity_Power_float(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                float _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_float(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                float _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_float(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                float _Clamp_C9BB189_Out_3;
                Unity_Clamp_float(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                float3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_float3(_NormalBlend_412E2B77_Out_2, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                float _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                float2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                float2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_float(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                float4 _UV_C884DDDE_Out_0 = IN.uv3;
                float2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_float(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                float _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                float _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                float _Split_9358BE5B_B_3 = 0;
                float _Split_9358BE5B_A_4 = 0;
                float2 _Vector2_992266D4_Out_0 = float2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                float2 _Branch_DD741EC2_Out_3;
                Unity_Branch_float2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                float _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                float _Multiply_B7675A94_Out_2;
                Unity_Multiply_float(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                float _Add_B3DB86EF_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                float _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_float(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                float2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                float _Property_DAA63F9C_Out_0 = _GlobalTiling;
                float _Divide_4B6448D6_Out_2;
                Unity_Divide_float(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                float4 _UV_2E4D7348_Out_0 = IN.uv0;
                float2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_float(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                float2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_float((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                float2 _Add_D29A7CEF_Out_2;
                Unity_Add_float2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_D29A7CEF_Out_2);
                float4 _SampleTexture2D_6ABE710E_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascadeNormal, sampler_BigCascadeNormal, _Add_D29A7CEF_Out_2);
                _SampleTexture2D_6ABE710E_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6ABE710E_RGBA_0);
                float _SampleTexture2D_6ABE710E_R_4 = _SampleTexture2D_6ABE710E_RGBA_0.r;
                float _SampleTexture2D_6ABE710E_G_5 = _SampleTexture2D_6ABE710E_RGBA_0.g;
                float _SampleTexture2D_6ABE710E_B_6 = _SampleTexture2D_6ABE710E_RGBA_0.b;
                float _SampleTexture2D_6ABE710E_A_7 = _SampleTexture2D_6ABE710E_RGBA_0.a;
                float _Property_944CEF1C_Out_0 = _BigCascadeNormalScale;
                float3 _NormalStrength_8AA324A2_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_6ABE710E_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8AA324A2_Out_2);
                float _Add_DD0F4500_Out_2;
                Unity_Add_float(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                float _Fraction_641D15D3_Out_1;
                Unity_Fraction_float(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                float2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_float(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                float2 _Add_47CB0CEA_Out_2;
                Unity_Add_float2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_47CB0CEA_Out_2);
                float4 _SampleTexture2D_6FC3A421_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascadeNormal, sampler_BigCascadeNormal, _Add_47CB0CEA_Out_2);
                _SampleTexture2D_6FC3A421_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6FC3A421_RGBA_0);
                float _SampleTexture2D_6FC3A421_R_4 = _SampleTexture2D_6FC3A421_RGBA_0.r;
                float _SampleTexture2D_6FC3A421_G_5 = _SampleTexture2D_6FC3A421_RGBA_0.g;
                float _SampleTexture2D_6FC3A421_B_6 = _SampleTexture2D_6FC3A421_RGBA_0.b;
                float _SampleTexture2D_6FC3A421_A_7 = _SampleTexture2D_6FC3A421_RGBA_0.a;
                float3 _NormalStrength_8264A1B8_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_6FC3A421_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8264A1B8_Out_2);
                float _Add_E6ED65B6_Out_2;
                Unity_Add_float(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                float _Multiply_E9A08C0_Out_2;
                Unity_Multiply_float(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                float _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_float(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                float3 _Lerp_F884F066_Out_3;
                Unity_Lerp_float3(_NormalStrength_8AA324A2_Out_2, _NormalStrength_8264A1B8_Out_2, (_Absolute_19D4C5A5_Out_1.xxx), _Lerp_F884F066_Out_3);
                float3 _Lerp_C8A32E85_Out_3;
                Unity_Lerp_float3(_Lerp_BA2C71FD_Out_3, _Lerp_F884F066_Out_3, (_Clamp_C3D0E6D0_Out_3.xxx), _Lerp_C8A32E85_Out_3);
                float _Split_42E433A0_R_1 = IN.VertexColor[0];
                float _Split_42E433A0_G_2 = IN.VertexColor[1];
                float _Split_42E433A0_B_3 = IN.VertexColor[2];
                float _Split_42E433A0_A_4 = IN.VertexColor[3];
                float3 _Lerp_556A8C4B_Out_3;
                Unity_Lerp_float3(_Lerp_C8A32E85_Out_3, _NormalBlend_412E2B77_Out_2, (_Split_42E433A0_R_1.xxx), _Lerp_556A8C4B_Out_3);
                float3 _Lerp_CD3A5C6C_Out_3;
                Unity_Lerp_float3(_Lerp_556A8C4B_Out_3, _Lerp_5B898C96_Out_3, (_Split_42E433A0_G_2.xxx), _Lerp_CD3A5C6C_Out_3);
                float3 _Lerp_52D4237F_Out_3;
                Unity_Lerp_float3(_Lerp_CD3A5C6C_Out_3, _Lerp_F884F066_Out_3, (_Split_42E433A0_B_3.xxx), _Lerp_52D4237F_Out_3);
                float _Property_C2D9BD80_Out_0 = _FarNormalPower;
                float3 _Vector3_3A6917E5_Out_0 = float3(_Property_C2D9BD80_Out_0, _Property_C2D9BD80_Out_0, 1);
                float3 _Multiply_C66EC037_Out_2;
                Unity_Multiply_float(_Vector3_3A6917E5_Out_0, _Lerp_52D4237F_Out_3, _Multiply_C66EC037_Out_2);
                float _Distance_2BC7BAC4_Out_2;
                Unity_Distance_float3(IN.AbsoluteWorldSpacePosition, _WorldSpaceCameraPos, _Distance_2BC7BAC4_Out_2);
                float _Property_F830ADD1_Out_0 = _FarNormalBlendStartDistance;
                float _Divide_FD4E31CF_Out_2;
                Unity_Divide_float(_Distance_2BC7BAC4_Out_2, _Property_F830ADD1_Out_0, _Divide_FD4E31CF_Out_2);
                float _Absolute_C7759968_Out_1;
                Unity_Absolute_float(_Divide_FD4E31CF_Out_2, _Absolute_C7759968_Out_1);
                float _Property_793038B1_Out_0 = _FarNormalBlendThreshold;
                float _Power_B974F588_Out_2;
                Unity_Power_float(_Absolute_C7759968_Out_1, _Property_793038B1_Out_0, _Power_B974F588_Out_2);
                float _Clamp_92AA7C53_Out_3;
                Unity_Clamp_float(_Power_B974F588_Out_2, 0, 1, _Clamp_92AA7C53_Out_3);
                float3 _Lerp_72DCEC20_Out_3;
                Unity_Lerp_float3(_Lerp_52D4237F_Out_3, _Multiply_C66EC037_Out_2, (_Clamp_92AA7C53_Out_3.xxx), _Lerp_72DCEC20_Out_3);
                float3 _Normalize_17DCA406_Out_1;
                Unity_Normalize_float3(_Lerp_72DCEC20_Out_3, _Normalize_17DCA406_Out_1);
                float _Split_6A7D546B_R_1 = _Normalize_17DCA406_Out_1[0];
                float _Split_6A7D546B_G_2 = _Normalize_17DCA406_Out_1[1];
                float _Split_6A7D546B_B_3 = _Normalize_17DCA406_Out_1[2];
                float _Split_6A7D546B_A_4 = 0;
                float4 _Combine_E07639F2_RGBA_4;
                float3 _Combine_E07639F2_RGB_5;
                float2 _Combine_E07639F2_RG_6;
                Unity_Combine_float(_Split_6A7D546B_R_1, _Split_6A7D546B_G_2, 0, 0, _Combine_E07639F2_RGBA_4, _Combine_E07639F2_RGB_5, _Combine_E07639F2_RG_6);
                float2 _Multiply_2F7622D8_Out_2;
                Unity_Multiply_float((_Property_FC343CDD_Out_0.xx), _Combine_E07639F2_RG_6, _Multiply_2F7622D8_Out_2);
                float2 _Multiply_9F154179_Out_2;
                Unity_Multiply_float((_ScreenPosition_1B148032_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_9F154179_Out_2);
                float2 _Add_FCAE1710_Out_2;
                Unity_Add_float2((_ScreenPosition_1B148032_Out_0.xy), _Multiply_9F154179_Out_2, _Add_FCAE1710_Out_2);
                float3 _SceneColor_5A25EB33_Out_1;
                Unity_SceneColor_float((float4(_Add_FCAE1710_Out_2, 0.0, 1.0)), _SceneColor_5A25EB33_Out_1);
                float4 _Property_C4180B07_Out_0 = _DeepColor;
                float4 _Property_B354F529_Out_0 = _ShalowColor;
                float4 _ScreenPosition_E4782AF8_Out_0 = float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                float _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_float(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                float _Multiply_39A1673A_Out_2;
                Unity_Multiply_float(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                float4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                float _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                float _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                float _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                float _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                float _Subtract_331D19CE_Out_2;
                Unity_Subtract_float(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                float _Property_46A80510_Out_0 = _ShalowFalloffMultiply;
                float _Multiply_55CDC796_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_46A80510_Out_0, _Multiply_55CDC796_Out_2);
                float _Absolute_DA749514_Out_1;
                Unity_Absolute_float(_Multiply_55CDC796_Out_2, _Absolute_DA749514_Out_1);
                float _Property_4D681D1C_Out_0 = _ShalowFalloffPower;
                float _Multiply_F7AB70ED_Out_2;
                Unity_Multiply_float(_Property_4D681D1C_Out_0, -1, _Multiply_F7AB70ED_Out_2);
                float _Power_3270BF29_Out_2;
                Unity_Power_float(_Absolute_DA749514_Out_1, _Multiply_F7AB70ED_Out_2, _Power_3270BF29_Out_2);
                float _Property_BB1D3A49_Out_0 = _BigCascadeTransparency;
                float _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_float(_Property_BB1D3A49_Out_0, _Clamp_C3D0E6D0_Out_3, _Multiply_6F5E4CCF_Out_2);
                float _Lerp_FE3B891E_Out_3;
                Unity_Lerp_float(_Power_3270BF29_Out_2, 100, _Multiply_6F5E4CCF_Out_2, _Lerp_FE3B891E_Out_3);
                float _Saturate_47EA3698_Out_1;
                Unity_Saturate_float(_Lerp_FE3B891E_Out_3, _Saturate_47EA3698_Out_1);
                float _Clamp_FA371D5_Out_3;
                Unity_Clamp_float(_Saturate_47EA3698_Out_1, 0, 1, _Clamp_FA371D5_Out_3);
                float4 _Lerp_E98C0337_Out_3;
                Unity_Lerp_float4(_Property_C4180B07_Out_0, _Property_B354F529_Out_0, (_Clamp_FA371D5_Out_3.xxxx), _Lerp_E98C0337_Out_3);
                float4 _SampleTexture2D_13F501DC_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_B51BFC_Out_2);
                float _SampleTexture2D_13F501DC_R_4 = _SampleTexture2D_13F501DC_RGBA_0.r;
                float _SampleTexture2D_13F501DC_G_5 = _SampleTexture2D_13F501DC_RGBA_0.g;
                float _SampleTexture2D_13F501DC_B_6 = _SampleTexture2D_13F501DC_RGBA_0.b;
                float _SampleTexture2D_13F501DC_A_7 = _SampleTexture2D_13F501DC_RGBA_0.a;
                float _Property_DF347AFD_Out_0 = _SlowWaterTranslucencyMultiply;
                float _Multiply_12D281E6_Out_2;
                Unity_Multiply_float(_SampleTexture2D_13F501DC_A_7, _Property_DF347AFD_Out_0, _Multiply_12D281E6_Out_2);
                float4 _SampleTexture2D_C713F57F_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_7772C3BA_Out_2);
                float _SampleTexture2D_C713F57F_R_4 = _SampleTexture2D_C713F57F_RGBA_0.r;
                float _SampleTexture2D_C713F57F_G_5 = _SampleTexture2D_C713F57F_RGBA_0.g;
                float _SampleTexture2D_C713F57F_B_6 = _SampleTexture2D_C713F57F_RGBA_0.b;
                float _SampleTexture2D_C713F57F_A_7 = _SampleTexture2D_C713F57F_RGBA_0.a;
                float4 _SampleTexture2D_5CD91024_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterTesselation, sampler_SlowWaterTesselation, _Add_C1F18389_Out_2);
                float _SampleTexture2D_5CD91024_R_4 = _SampleTexture2D_5CD91024_RGBA_0.r;
                float _SampleTexture2D_5CD91024_G_5 = _SampleTexture2D_5CD91024_RGBA_0.g;
                float _SampleTexture2D_5CD91024_B_6 = _SampleTexture2D_5CD91024_RGBA_0.b;
                float _SampleTexture2D_5CD91024_A_7 = _SampleTexture2D_5CD91024_RGBA_0.a;
                float _Lerp_AFD3E4F7_Out_3;
                Unity_Lerp_float(_SampleTexture2D_C713F57F_A_7, _SampleTexture2D_5CD91024_A_7, _Absolute_6685A82A_Out_1, _Lerp_AFD3E4F7_Out_3);
                float _Multiply_38871AB2_Out_2;
                Unity_Multiply_float(_Lerp_AFD3E4F7_Out_3, _Property_DF347AFD_Out_0, _Multiply_38871AB2_Out_2);
                float _Add_6B3A33E0_Out_2;
                Unity_Add_float(_Multiply_12D281E6_Out_2, _Multiply_38871AB2_Out_2, _Add_6B3A33E0_Out_2);
                float4 _SampleTexture2D_28CB720F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_188C8FD3_Out_2);
                float _SampleTexture2D_28CB720F_R_4 = _SampleTexture2D_28CB720F_RGBA_0.r;
                float _SampleTexture2D_28CB720F_G_5 = _SampleTexture2D_28CB720F_RGBA_0.g;
                float _SampleTexture2D_28CB720F_B_6 = _SampleTexture2D_28CB720F_RGBA_0.b;
                float _SampleTexture2D_28CB720F_A_7 = _SampleTexture2D_28CB720F_RGBA_0.a;
                float4 _SampleTexture2D_8FF1FC6F_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascadeWaterTess, sampler_SmallCascadeWaterTess, _Add_3E5AC13E_Out_2);
                float _SampleTexture2D_8FF1FC6F_R_4 = _SampleTexture2D_8FF1FC6F_RGBA_0.r;
                float _SampleTexture2D_8FF1FC6F_G_5 = _SampleTexture2D_8FF1FC6F_RGBA_0.g;
                float _SampleTexture2D_8FF1FC6F_B_6 = _SampleTexture2D_8FF1FC6F_RGBA_0.b;
                float _SampleTexture2D_8FF1FC6F_A_7 = _SampleTexture2D_8FF1FC6F_RGBA_0.a;
                float _Lerp_4087DCAB_Out_3;
                Unity_Lerp_float(_SampleTexture2D_28CB720F_A_7, _SampleTexture2D_8FF1FC6F_A_7, _Absolute_D56AD49D_Out_1, _Lerp_4087DCAB_Out_3);
                float _Multiply_886F60D0_Out_2;
                Unity_Multiply_float(_Lerp_4087DCAB_Out_3, _Clamp_C9BB189_Out_3, _Multiply_886F60D0_Out_2);
                float _Property_34EA6884_Out_0 = _SmallCascadeTranslucencyMultiply;
                float _Multiply_A5195DC2_Out_2;
                Unity_Multiply_float(_Multiply_886F60D0_Out_2, _Property_34EA6884_Out_0, _Multiply_A5195DC2_Out_2);
                float _Add_DB50B67C_Out_2;
                Unity_Add_float(_Add_6B3A33E0_Out_2, _Multiply_A5195DC2_Out_2, _Add_DB50B67C_Out_2);
                float4 _SampleTexture2D_3D04E744_RGBA_0 = SAMPLE_TEXTURE2D(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_D29A7CEF_Out_2);
                float _SampleTexture2D_3D04E744_R_4 = _SampleTexture2D_3D04E744_RGBA_0.r;
                float _SampleTexture2D_3D04E744_G_5 = _SampleTexture2D_3D04E744_RGBA_0.g;
                float _SampleTexture2D_3D04E744_B_6 = _SampleTexture2D_3D04E744_RGBA_0.b;
                float _SampleTexture2D_3D04E744_A_7 = _SampleTexture2D_3D04E744_RGBA_0.a;
                float4 _SampleTexture2D_FDC3D2E_RGBA_0 = SAMPLE_TEXTURE2D(BigCascadeWaterTess, samplerBigCascadeWaterTess, _Add_47CB0CEA_Out_2);
                float _SampleTexture2D_FDC3D2E_R_4 = _SampleTexture2D_FDC3D2E_RGBA_0.r;
                float _SampleTexture2D_FDC3D2E_G_5 = _SampleTexture2D_FDC3D2E_RGBA_0.g;
                float _SampleTexture2D_FDC3D2E_B_6 = _SampleTexture2D_FDC3D2E_RGBA_0.b;
                float _SampleTexture2D_FDC3D2E_A_7 = _SampleTexture2D_FDC3D2E_RGBA_0.a;
                float _Lerp_627AFBE_Out_3;
                Unity_Lerp_float(_SampleTexture2D_3D04E744_A_7, _SampleTexture2D_FDC3D2E_A_7, _Absolute_19D4C5A5_Out_1, _Lerp_627AFBE_Out_3);
                float _Property_928C8D62_Out_0 = _BigCascadeTranslucencyMultiply;
                float _Multiply_5E3A9C4F_Out_2;
                Unity_Multiply_float(_Lerp_627AFBE_Out_3, _Property_928C8D62_Out_0, _Multiply_5E3A9C4F_Out_2);
                float _Multiply_985131BF_Out_2;
                Unity_Multiply_float(_Multiply_5E3A9C4F_Out_2, _Clamp_C3D0E6D0_Out_3, _Multiply_985131BF_Out_2);
                float _Add_48913743_Out_2;
                Unity_Add_float(_Add_DB50B67C_Out_2, _Multiply_985131BF_Out_2, _Add_48913743_Out_2);
                float _Lerp_9F2FC6DE_Out_3;
                Unity_Lerp_float(_Add_48913743_Out_2, _Add_6B3A33E0_Out_2, _Split_42E433A0_R_1, _Lerp_9F2FC6DE_Out_3);
                float _Lerp_FB484DB5_Out_3;
                Unity_Lerp_float(_Lerp_9F2FC6DE_Out_3, _Multiply_A5195DC2_Out_2, _Split_42E433A0_G_2, _Lerp_FB484DB5_Out_3);
                float _Lerp_895F9AAF_Out_3;
                Unity_Lerp_float(_Lerp_FB484DB5_Out_3, _Multiply_985131BF_Out_2, _Split_42E433A0_B_3, _Lerp_895F9AAF_Out_3);
                float _Property_34B150E6_Out_0 = _WaveTranslucencyHardness;
                float _Multiply_814E887D_Out_2;
                Unity_Multiply_float(_Lerp_895F9AAF_Out_3, _Property_34B150E6_Out_0, _Multiply_814E887D_Out_2);
                float _Absolute_48E4873A_Out_1;
                Unity_Absolute_float(_Multiply_814E887D_Out_2, _Absolute_48E4873A_Out_1);
                float _Property_9EFC9ABB_Out_0 = _WaveTranslucencyPower;
                float _Power_4A7A9922_Out_2;
                Unity_Power_float(_Absolute_48E4873A_Out_1, _Property_9EFC9ABB_Out_0, _Power_4A7A9922_Out_2);
                float _Property_CC520751_Out_0 = _WaveTranslucencyMultiply;
                float _Multiply_A80435F6_Out_2;
                Unity_Multiply_float(_Power_4A7A9922_Out_2, _Property_CC520751_Out_0, _Multiply_A80435F6_Out_2);
                float _Property_4A52B221_Out_0 = _WaveTranslucencyFallOffDistance;
                float _Divide_9A2ADE25_Out_2;
                Unity_Divide_float(_Distance_2BC7BAC4_Out_2, _Property_4A52B221_Out_0, _Divide_9A2ADE25_Out_2);
                float _Lerp_2EB5E047_Out_3;
                Unity_Lerp_float(_Multiply_A80435F6_Out_2, 0, _Divide_9A2ADE25_Out_2, _Lerp_2EB5E047_Out_3);
                float _Clamp_844D27EC_Out_3;
                Unity_Clamp_float(_Lerp_2EB5E047_Out_3, 0, 1, _Clamp_844D27EC_Out_3);
                float4 _Lerp_B4C04BFD_Out_3;
                Unity_Lerp_float4(_Lerp_E98C0337_Out_3, _Property_B354F529_Out_0, (_Clamp_844D27EC_Out_3.xxxx), _Lerp_B4C04BFD_Out_3);
                float3 _Multiply_D633B72E_Out_2;
                Unity_Multiply_float((_Lerp_B4C04BFD_Out_3.xyz), _SceneColor_5A25EB33_Out_1, _Multiply_D633B72E_Out_2);
                float _Property_6D149C33_Out_0 = _WaterAlphaMultiply;
                float _Multiply_BFF3EB6E_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_6D149C33_Out_0, _Multiply_BFF3EB6E_Out_2);
                float _Clamp_D42DB1DE_Out_3;
                Unity_Clamp_float(_Multiply_BFF3EB6E_Out_2, 0, 1, _Clamp_D42DB1DE_Out_3);
                float _Property_BF7B7D6B_Out_0 = _WaterAlphaPower;
                float _Power_84CE25F5_Out_2;
                Unity_Power_float(_Clamp_D42DB1DE_Out_3, _Property_BF7B7D6B_Out_0, _Power_84CE25F5_Out_2);
                float _Clamp_F8CBC0B_Out_3;
                Unity_Clamp_float(_Power_84CE25F5_Out_2, 0, 1, _Clamp_F8CBC0B_Out_3);
                float3 _Lerp_E9A0ECDE_Out_3;
                Unity_Lerp_float3(_Multiply_D633B72E_Out_2, (_Lerp_B4C04BFD_Out_3.xyz), (_Clamp_F8CBC0B_Out_3.xxx), _Lerp_E9A0ECDE_Out_3);
                float _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                float _Multiply_312FB549_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                float _Clamp_43A46A4A_Out_3;
                Unity_Clamp_float(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                float _Absolute_97151155_Out_1;
                Unity_Absolute_float(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                float _Property_D7C9F55F_Out_0 = _CleanFalloffPower;
                float _Power_AD928E85_Out_2;
                Unity_Power_float(_Absolute_97151155_Out_1, _Property_D7C9F55F_Out_0, _Power_AD928E85_Out_2);
                float _Clamp_9B4149BD_Out_3;
                Unity_Clamp_float(_Power_AD928E85_Out_2, 0, 1, _Clamp_9B4149BD_Out_3);
                float3 _Lerp_DF8F6DB6_Out_3;
                Unity_Lerp_float3(_SceneColor_5A25EB33_Out_1, _Lerp_E9A0ECDE_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_DF8F6DB6_Out_3);
                float3 _Property_71824DF9_Out_0 = _FoamColor;
                float _Property_6A3E12E9_Out_0 = _FoamDepth;
                float _Add_D65144A5_Out_2;
                Unity_Add_float(_Subtract_331D19CE_Out_2, _Property_6A3E12E9_Out_0, _Add_D65144A5_Out_2);
                float _Absolute_236EA369_Out_1;
                Unity_Absolute_float(_Add_D65144A5_Out_2, _Absolute_236EA369_Out_1);
                float _Property_5092872F_Out_0 = _FoamFalloff;
                float _Power_C278752C_Out_2;
                Unity_Power_float(_Absolute_236EA369_Out_1, _Property_5092872F_Out_0, _Power_C278752C_Out_2);
                float _Saturate_F768EEA6_Out_1;
                Unity_Saturate_float(_Power_C278752C_Out_2, _Saturate_F768EEA6_Out_1);
                float _Property_A8CF8708_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_25764F01_Out_0 = _FoamSpeed;
                float2 _Property_3E47978_Out_0 = _FoamTiling;
                float2 _Multiply_DE80E1D6_Out_2;
                Unity_Multiply_float(_Property_25764F01_Out_0, _Property_3E47978_Out_0, _Multiply_DE80E1D6_Out_2);
                float4 _UV_E1385FB5_Out_0 = IN.uv3;
                float2 _Multiply_3C9DE3D3_Out_2;
                Unity_Multiply_float(_Multiply_DE80E1D6_Out_2, (_UV_E1385FB5_Out_0.xy), _Multiply_3C9DE3D3_Out_2);
                float _Split_90264A5B_R_1 = _Multiply_3C9DE3D3_Out_2[0];
                float _Split_90264A5B_G_2 = _Multiply_3C9DE3D3_Out_2[1];
                float _Split_90264A5B_B_3 = 0;
                float _Split_90264A5B_A_4 = 0;
                float2 _Vector2_8C003284_Out_0 = float2(_Split_90264A5B_G_2, _Split_90264A5B_R_1);
                float2 _Branch_81C13B1A_Out_3;
                Unity_Branch_float2(_Property_A8CF8708_Out_0, _Multiply_3C9DE3D3_Out_2, _Vector2_8C003284_Out_0, _Branch_81C13B1A_Out_3);
                float2 _Multiply_F37F0047_Out_2;
                Unity_Multiply_float(_Branch_81C13B1A_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_F37F0047_Out_2);
                float _Property_70842CE7_Out_0 = _GlobalTiling;
                float _Divide_D13271E5_Out_2;
                Unity_Divide_float(1, _Property_70842CE7_Out_0, _Divide_D13271E5_Out_2);
                float4 _UV_E210B498_Out_0 = IN.uv0;
                float2 _Multiply_38B9004E_Out_2;
                Unity_Multiply_float(_Property_3E47978_Out_0, (_UV_E210B498_Out_0.xy), _Multiply_38B9004E_Out_2);
                float2 _Multiply_FED7B7C8_Out_2;
                Unity_Multiply_float((_Divide_D13271E5_Out_2.xx), _Multiply_38B9004E_Out_2, _Multiply_FED7B7C8_Out_2);
                float2 _Add_F1148D00_Out_2;
                Unity_Add_float2(_Multiply_F37F0047_Out_2, _Multiply_FED7B7C8_Out_2, _Add_F1148D00_Out_2);
                float3 _ChannelMask_70068C75_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_BA2C71FD_Out_3, _ChannelMask_70068C75_Out_1);
                float3 _Multiply_134985D4_Out_2;
                Unity_Multiply_float(_ChannelMask_70068C75_Out_1, float3(0.03, 0.03, 0), _Multiply_134985D4_Out_2);
                float2 _Add_C3A54034_Out_2;
                Unity_Add_float2(_Add_F1148D00_Out_2, (_Multiply_134985D4_Out_2.xy), _Add_C3A54034_Out_2);
                float4 _SampleTexture2D_D6FF940D_RGBA_0 = SAMPLE_TEXTURE2D(_Foam, sampler_Foam, _Add_C3A54034_Out_2);
                float _SampleTexture2D_D6FF940D_R_4 = _SampleTexture2D_D6FF940D_RGBA_0.r;
                float _SampleTexture2D_D6FF940D_G_5 = _SampleTexture2D_D6FF940D_RGBA_0.g;
                float _SampleTexture2D_D6FF940D_B_6 = _SampleTexture2D_D6FF940D_RGBA_0.b;
                float _SampleTexture2D_D6FF940D_A_7 = _SampleTexture2D_D6FF940D_RGBA_0.a;
                float2 _Multiply_3FB3476F_Out_2;
                Unity_Multiply_float(_Branch_81C13B1A_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_3FB3476F_Out_2);
                float2 _Add_7633CAE7_Out_2;
                Unity_Add_float2(_Multiply_FED7B7C8_Out_2, _Multiply_3FB3476F_Out_2, _Add_7633CAE7_Out_2);
                float2 _Add_14D7BEE1_Out_2;
                Unity_Add_float2(_Add_7633CAE7_Out_2, (_Multiply_134985D4_Out_2.xy), _Add_14D7BEE1_Out_2);
                float4 _SampleTexture2D_80481243_RGBA_0 = SAMPLE_TEXTURE2D(_Foam, sampler_Foam, _Add_14D7BEE1_Out_2);
                float _SampleTexture2D_80481243_R_4 = _SampleTexture2D_80481243_RGBA_0.r;
                float _SampleTexture2D_80481243_G_5 = _SampleTexture2D_80481243_RGBA_0.g;
                float _SampleTexture2D_80481243_B_6 = _SampleTexture2D_80481243_RGBA_0.b;
                float _SampleTexture2D_80481243_A_7 = _SampleTexture2D_80481243_RGBA_0.a;
                float _Lerp_408AE005_Out_3;
                Unity_Lerp_float(_SampleTexture2D_D6FF940D_A_7, _SampleTexture2D_80481243_A_7, _Absolute_6685A82A_Out_1, _Lerp_408AE005_Out_3);
                float _Multiply_CE5D1661_Out_2;
                Unity_Multiply_float(_Saturate_F768EEA6_Out_1, _Lerp_408AE005_Out_3, _Multiply_CE5D1661_Out_2);
                float _Lerp_25030EB5_Out_3;
                Unity_Lerp_float(_Multiply_CE5D1661_Out_2, 0, _Clamp_C3D0E6D0_Out_3, _Lerp_25030EB5_Out_3);
                float _Clamp_CDFBCC47_Out_3;
                Unity_Clamp_float(_Lerp_25030EB5_Out_3, 0, 1, _Clamp_CDFBCC47_Out_3);
                float _Property_C10720A6_Out_0 = _FoamWaveHardness;
                float _Multiply_E0985C9B_Out_2;
                Unity_Multiply_float(_Lerp_AFD3E4F7_Out_3, _Property_C10720A6_Out_0, _Multiply_E0985C9B_Out_2);
                float _Absolute_47BFD663_Out_1;
                Unity_Absolute_float(_Multiply_E0985C9B_Out_2, _Absolute_47BFD663_Out_1);
                float _Property_7556FCA1_Out_0 = _FoamWavePower;
                float _Power_E4C90FA4_Out_2;
                Unity_Power_float(_Absolute_47BFD663_Out_1, _Property_7556FCA1_Out_0, _Power_E4C90FA4_Out_2);
                float _Property_C5E24EE_Out_0 = _FoamWaveMultiply;
                float _Multiply_49E6B3AD_Out_2;
                Unity_Multiply_float(_Power_E4C90FA4_Out_2, _Property_C5E24EE_Out_0, _Multiply_49E6B3AD_Out_2);
                float _Clamp_41A39F5E_Out_3;
                Unity_Clamp_float(_Multiply_49E6B3AD_Out_2, 0, 1, _Clamp_41A39F5E_Out_3);
                float _Multiply_6E6B7134_Out_2;
                Unity_Multiply_float(_Clamp_CDFBCC47_Out_3, _Clamp_41A39F5E_Out_3, _Multiply_6E6B7134_Out_2);
                float3 _Lerp_6998DF58_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Property_71824DF9_Out_0, (_Multiply_6E6B7134_Out_2.xxx), _Lerp_6998DF58_Out_3);
                float4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascade, sampler_SmallCascade, _Add_188C8FD3_Out_2);
                float _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                float _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                float _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                float _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                float4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_SmallCascade, sampler_SmallCascade, _Add_3E5AC13E_Out_2);
                float _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                float _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                float _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                float _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                float _Blend_A1B262EF_Out_2;
                Unity_Blend_Overwrite_float(_SampleTexture2D_B8ACE3F1_A_7, _SampleTexture2D_A1621BBD_A_7, _Blend_A1B262EF_Out_2, _Absolute_D56AD49D_Out_1);
                float _Property_50DF1CAB_Out_0 = _UVVDirection1UDirection0;
                float2 _Property_A4A55C8D_Out_0 = _NoiseSpeed;
                float2 _Property_986C2E1B_Out_0 = _NoiseTiling;
                float2 _Multiply_778A9500_Out_2;
                Unity_Multiply_float(_Property_A4A55C8D_Out_0, _Property_986C2E1B_Out_0, _Multiply_778A9500_Out_2);
                float4 _UV_4A477E20_Out_0 = IN.uv3;
                float2 _Multiply_E53528CB_Out_2;
                Unity_Multiply_float(_Multiply_778A9500_Out_2, (_UV_4A477E20_Out_0.xy), _Multiply_E53528CB_Out_2);
                float _Split_A3C5F2B5_R_1 = _Multiply_E53528CB_Out_2[0];
                float _Split_A3C5F2B5_G_2 = _Multiply_E53528CB_Out_2[1];
                float _Split_A3C5F2B5_B_3 = 0;
                float _Split_A3C5F2B5_A_4 = 0;
                float2 _Vector2_6D67D273_Out_0 = float2(_Split_A3C5F2B5_G_2, _Split_A3C5F2B5_R_1);
                float2 _Branch_EDA2C0E3_Out_3;
                Unity_Branch_float2(_Property_50DF1CAB_Out_0, _Multiply_E53528CB_Out_2, _Vector2_6D67D273_Out_0, _Branch_EDA2C0E3_Out_3);
                float _Fraction_2FBB1852_Out_1;
                Unity_Fraction_float(_Add_7EF542FE_Out_2, _Fraction_2FBB1852_Out_1);
                float2 _Multiply_39A54641_Out_2;
                Unity_Multiply_float(_Branch_EDA2C0E3_Out_3, (_Fraction_2FBB1852_Out_1.xx), _Multiply_39A54641_Out_2);
                float _Property_82193ED3_Out_0 = _GlobalTiling;
                float _Divide_411EED11_Out_2;
                Unity_Divide_float(1, _Property_82193ED3_Out_0, _Divide_411EED11_Out_2);
                float4 _UV_F9D3A262_Out_0 = IN.uv0;
                float2 _Multiply_9C31F9C2_Out_2;
                Unity_Multiply_float(_Property_986C2E1B_Out_0, (_UV_F9D3A262_Out_0.xy), _Multiply_9C31F9C2_Out_2);
                float2 _Multiply_E6E2F026_Out_2;
                Unity_Multiply_float((_Divide_411EED11_Out_2.xx), _Multiply_9C31F9C2_Out_2, _Multiply_E6E2F026_Out_2);
                float2 _Add_BADC8439_Out_2;
                Unity_Add_float2(_Multiply_39A54641_Out_2, _Multiply_E6E2F026_Out_2, _Add_BADC8439_Out_2);
                float3 _ChannelMask_CFDD80FE_Out_1;
                Unity_ChannelMask_RedGreen_float3 (_Lerp_BA2C71FD_Out_3, _ChannelMask_CFDD80FE_Out_1);
                float3 _Multiply_A40BA8F9_Out_2;
                Unity_Multiply_float(_ChannelMask_CFDD80FE_Out_1, float3(0.03, 0.03, 0), _Multiply_A40BA8F9_Out_2);
                float2 _Add_6D99D51F_Out_2;
                Unity_Add_float2(_Add_BADC8439_Out_2, (_Multiply_A40BA8F9_Out_2.xy), _Add_6D99D51F_Out_2);
                float4 _SampleTexture2D_D803AB07_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_6D99D51F_Out_2);
                float _SampleTexture2D_D803AB07_R_4 = _SampleTexture2D_D803AB07_RGBA_0.r;
                float _SampleTexture2D_D803AB07_G_5 = _SampleTexture2D_D803AB07_RGBA_0.g;
                float _SampleTexture2D_D803AB07_B_6 = _SampleTexture2D_D803AB07_RGBA_0.b;
                float _SampleTexture2D_D803AB07_A_7 = _SampleTexture2D_D803AB07_RGBA_0.a;
                float _Fraction_F51ED0A1_Out_1;
                Unity_Fraction_float(_Add_42A4AEEC_Out_2, _Fraction_F51ED0A1_Out_1);
                float2 _Multiply_EEA6AA5B_Out_2;
                Unity_Multiply_float(_Branch_EDA2C0E3_Out_3, (_Fraction_F51ED0A1_Out_1.xx), _Multiply_EEA6AA5B_Out_2);
                float2 _Add_9509D7CE_Out_2;
                Unity_Add_float2(_Multiply_E6E2F026_Out_2, _Multiply_EEA6AA5B_Out_2, _Add_9509D7CE_Out_2);
                float2 _Add_3E9F55C4_Out_2;
                Unity_Add_float2(_Add_9509D7CE_Out_2, (_Multiply_A40BA8F9_Out_2.xy), _Add_3E9F55C4_Out_2);
                float4 _SampleTexture2D_198CC76A_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_3E9F55C4_Out_2);
                float _SampleTexture2D_198CC76A_R_4 = _SampleTexture2D_198CC76A_RGBA_0.r;
                float _SampleTexture2D_198CC76A_G_5 = _SampleTexture2D_198CC76A_RGBA_0.g;
                float _SampleTexture2D_198CC76A_B_6 = _SampleTexture2D_198CC76A_RGBA_0.b;
                float _SampleTexture2D_198CC76A_A_7 = _SampleTexture2D_198CC76A_RGBA_0.a;
                float _Lerp_51CEF3BF_Out_3;
                Unity_Lerp_float(_SampleTexture2D_D803AB07_A_7, _SampleTexture2D_198CC76A_A_7, _Absolute_D56AD49D_Out_1, _Lerp_51CEF3BF_Out_3);
                float _Absolute_38E6503D_Out_1;
                Unity_Absolute_float(_Lerp_51CEF3BF_Out_3, _Absolute_38E6503D_Out_1);
                float _Property_C1134212_Out_0 = _SmallCascadeNoisePower;
                float _Power_483D9151_Out_2;
                Unity_Power_float(_Absolute_38E6503D_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                float _Property_8B0E8794_Out_0 = _SmallCascadeNoiseMultiply;
                float _Multiply_E26A26BB_Out_2;
                Unity_Multiply_float(_Power_483D9151_Out_2, _Property_8B0E8794_Out_0, _Multiply_E26A26BB_Out_2);
                float _Clamp_805729EB_Out_3;
                Unity_Clamp_float(_Multiply_E26A26BB_Out_2, 0, 1, _Clamp_805729EB_Out_3);
                float _Lerp_39572874_Out_3;
                Unity_Lerp_float(0, _Blend_A1B262EF_Out_2, _Clamp_805729EB_Out_3, _Lerp_39572874_Out_3);
                float3 _Property_4A612457_Out_0 = _SmallCascadeColor;
                float3 _Multiply_E85EE897_Out_2;
                Unity_Multiply_float((_Lerp_39572874_Out_3.xxx), _Property_4A612457_Out_0, _Multiply_E85EE897_Out_2);
                float _Absolute_5DF2B9D0_Out_1;
                Unity_Absolute_float(_Blend_A1B262EF_Out_2, _Absolute_5DF2B9D0_Out_1);
                float _Property_97A26DCC_Out_0 = _SmallCascadeFoamFalloff;
                float _Power_328AD5E3_Out_2;
                Unity_Power_float(_Absolute_5DF2B9D0_Out_1, _Property_97A26DCC_Out_0, _Power_328AD5E3_Out_2);
                float _Clamp_33692D9C_Out_3;
                Unity_Clamp_float(_Power_328AD5E3_Out_2, 0, 1, _Clamp_33692D9C_Out_3);
                float _Lerp_8877E3D4_Out_3;
                Unity_Lerp_float(0, _Clamp_33692D9C_Out_3, _Clamp_C9BB189_Out_3, _Lerp_8877E3D4_Out_3);
                float3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_float3(_Lerp_6998DF58_Out_3, _Multiply_E85EE897_Out_2, (_Lerp_8877E3D4_Out_3.xxx), _Lerp_4F98523C_Out_3);
                float4 _SampleTexture2D_387AEB22_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascade, sampler_BigCascade, _Add_D29A7CEF_Out_2);
                float _SampleTexture2D_387AEB22_R_4 = _SampleTexture2D_387AEB22_RGBA_0.r;
                float _SampleTexture2D_387AEB22_G_5 = _SampleTexture2D_387AEB22_RGBA_0.g;
                float _SampleTexture2D_387AEB22_B_6 = _SampleTexture2D_387AEB22_RGBA_0.b;
                float _SampleTexture2D_387AEB22_A_7 = _SampleTexture2D_387AEB22_RGBA_0.a;
                float4 _SampleTexture2D_9FEF114B_RGBA_0 = SAMPLE_TEXTURE2D(_BigCascade, sampler_BigCascade, _Add_47CB0CEA_Out_2);
                float _SampleTexture2D_9FEF114B_R_4 = _SampleTexture2D_9FEF114B_RGBA_0.r;
                float _SampleTexture2D_9FEF114B_G_5 = _SampleTexture2D_9FEF114B_RGBA_0.g;
                float _SampleTexture2D_9FEF114B_B_6 = _SampleTexture2D_9FEF114B_RGBA_0.b;
                float _SampleTexture2D_9FEF114B_A_7 = _SampleTexture2D_9FEF114B_RGBA_0.a;
                float _Blend_FAB812B4_Out_2;
                Unity_Blend_Overwrite_float(_SampleTexture2D_387AEB22_A_7, _SampleTexture2D_9FEF114B_A_7, _Blend_FAB812B4_Out_2, _Absolute_19D4C5A5_Out_1);
                float _Multiply_2D163AB3_Out_2;
                Unity_Multiply_float(0.5, _Blend_FAB812B4_Out_2, _Multiply_2D163AB3_Out_2);
                float _Property_5515474F_Out_0 = _BigCascadeNoisePower;
                float _Power_E5773568_Out_2;
                Unity_Power_float(_Absolute_38E6503D_Out_1, _Property_5515474F_Out_0, _Power_E5773568_Out_2);
                float _Property_2C8FB0D9_Out_0 = _BigCascadeNoiseMultiply;
                float _Multiply_9128FAF6_Out_2;
                Unity_Multiply_float(_Power_E5773568_Out_2, _Property_2C8FB0D9_Out_0, _Multiply_9128FAF6_Out_2);
                float _Clamp_1E99CDDE_Out_3;
                Unity_Clamp_float(_Multiply_9128FAF6_Out_2, 0, 1, _Clamp_1E99CDDE_Out_3);
                float _Lerp_50210667_Out_3;
                Unity_Lerp_float(_Multiply_2D163AB3_Out_2, _Blend_FAB812B4_Out_2, _Clamp_1E99CDDE_Out_3, _Lerp_50210667_Out_3);
                float3 _Property_DB02E9C9_Out_0 = _BigCascadeColor;
                float3 _Multiply_630AB59_Out_2;
                Unity_Multiply_float((_Lerp_50210667_Out_3.xxx), _Property_DB02E9C9_Out_0, _Multiply_630AB59_Out_2);
                float _Absolute_E807A97_Out_1;
                Unity_Absolute_float(_Blend_FAB812B4_Out_2, _Absolute_E807A97_Out_1);
                float _Property_97864BE9_Out_0 = Big_Cascade_Foam_Falloff;
                float _Power_F37DBF08_Out_2;
                Unity_Power_float(_Absolute_E807A97_Out_1, _Property_97864BE9_Out_0, _Power_F37DBF08_Out_2);
                float _Clamp_142C06F9_Out_3;
                Unity_Clamp_float(_Power_F37DBF08_Out_2, 0, 1, _Clamp_142C06F9_Out_3);
                float _Lerp_6316FED8_Out_3;
                Unity_Lerp_float(0, _Clamp_142C06F9_Out_3, _Clamp_C3D0E6D0_Out_3, _Lerp_6316FED8_Out_3);
                float3 _Lerp_96C773B7_Out_3;
                Unity_Lerp_float3(_Lerp_4F98523C_Out_3, _Multiply_630AB59_Out_2, (_Lerp_6316FED8_Out_3.xxx), _Lerp_96C773B7_Out_3);
                float3 _Lerp_8DC18263_Out_3;
                Unity_Lerp_float3(_Lerp_96C773B7_Out_3, _Lerp_DF8F6DB6_Out_3, (_Split_42E433A0_R_1.xxx), _Lerp_8DC18263_Out_3);
                float3 _Lerp_39AFE3C2_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Multiply_E85EE897_Out_2, (_Clamp_33692D9C_Out_3.xxx), _Lerp_39AFE3C2_Out_3);
                float3 _Lerp_78BD1AA8_Out_3;
                Unity_Lerp_float3(_Lerp_8DC18263_Out_3, _Lerp_39AFE3C2_Out_3, (_Split_42E433A0_G_2.xxx), _Lerp_78BD1AA8_Out_3);
                float3 _Lerp_8E1AA6D9_Out_3;
                Unity_Lerp_float3(_Lerp_DF8F6DB6_Out_3, _Multiply_630AB59_Out_2, (_Clamp_142C06F9_Out_3.xxx), _Lerp_8E1AA6D9_Out_3);
                float3 _Lerp_EE19DF0F_Out_3;
                Unity_Lerp_float3(_Lerp_78BD1AA8_Out_3, _Lerp_8E1AA6D9_Out_3, (_Split_42E433A0_B_3.xxx), _Lerp_EE19DF0F_Out_3);
                float _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                float _Property_44A9A39E_Out_0 = _EdgeFalloffMultiply;
                float _Multiply_943A3DD9_Out_2;
                Unity_Multiply_float(_Subtract_331D19CE_Out_2, _Property_44A9A39E_Out_0, _Multiply_943A3DD9_Out_2);
                float _Clamp_16BD4100_Out_3;
                Unity_Clamp_float(_Multiply_943A3DD9_Out_2, 0, 1, _Clamp_16BD4100_Out_3);
                float _Absolute_1003CC59_Out_1;
                Unity_Absolute_float(_Clamp_16BD4100_Out_3, _Absolute_1003CC59_Out_1);
                float _Property_3A9F02A2_Out_0 = _EdgeFalloffPower;
                float _Power_54D889D2_Out_2;
                Unity_Power_float(_Absolute_1003CC59_Out_1, _Property_3A9F02A2_Out_0, _Power_54D889D2_Out_2);
                float _Clamp_A8945B73_Out_3;
                Unity_Clamp_float(_Power_54D889D2_Out_2, 0, 1, _Clamp_A8945B73_Out_3);
                float _Multiply_73E319C1_Out_2;
                Unity_Multiply_float(_Clamp_A8945B73_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                float _Property_6C82272C_Out_0 = _BackfaceAlpha;
                float _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_float(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                float _Branch_6D78BA69_Out_3;
                Unity_Branch_float(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                surface.Albedo = _Lerp_EE19DF0F_Out_3;
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 uv3 : TEXCOORD3;
                float4 color : COLOR;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS;
                float3 normalWS;
                float4 tangentWS;
                float4 texCoord0;
                float4 texCoord3;
                float4 color;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
            };
            
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float3 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
                float4 interp03 : TEXCOORD3;
                float4 interp04 : TEXCOORD4;
                float4 interp05 : TEXCOORD5;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord3;
                output.interp05.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord3 = input.interp04.xyzw;
                output.color = input.interp05.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
                output.uv0 =                         input.uv0;
                output.uv3 =                         input.uv3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            	// must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            	float3 unnormalizedNormalWS = input.normalWS;
                const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            
            	// use bitangent on the fly like in hdrp
            	// IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
                float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
            	float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
            
                output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            
            	// to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
            	// This is explained in section 2.2 in "surface gradient based bump mapping framework"
                output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
            	output.WorldSpaceBiTangent =         renormFactor*bitang;
            
                output.WorldSpacePosition =          input.positionWS;
                output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
                output.uv0 =                         input.texCoord0;
                output.uv3 =                         input.texCoord3;
                output.VertexColor =                 input.color;
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
                BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
            ENDHLSL
        }
        
    }
    CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
