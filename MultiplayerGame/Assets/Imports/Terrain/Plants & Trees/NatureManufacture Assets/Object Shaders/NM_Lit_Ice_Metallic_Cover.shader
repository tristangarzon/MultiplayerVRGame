Shader "NatureManufacture/URP/Ice/Ice Metallic Lit Cover"
{
    Properties
    {
        _DeepColor("Deep Color", Color) = (0, 0, 0, 0)
        _BaseColor("Ice Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_BaseColorMap("Ice Base Map", 2D) = "white" {}
        [ToggleUI]_BaseUsePlanarUV("Ice Base Use Planar UV", Float) = 0
        _BaseTilingOffset("Ice Base Tiling and Offset", Vector) = (1, 1, 0, 0)
        _IceNoiseScale("Ice Noise Scale", Float) = 3
        _IceNoiseContrast("Ice Noise Contrast", Float) = 1
        _IceNoisePower("Ice Noise Power", Float) = 1
        [NoScaleOffset]_BaseNormalMap("Ice Normal Map", 2D) = "bump" {}
        _BaseNormalScale("Ice Base Normal Scale", Range(0, 8)) = 0.3
        [NoScaleOffset]_IceNoiseNormal("Ice Noise Normal", 2D) = "white" {}
        _NoiseNormalScale("Ice Noise Normal Scale", Range(0, 8)) = 0.05
        _BaseMetallic("Ice Base Metallic", Range(0, 1)) = 1
        _BaseAO("Ice Base AO", Range(0, 1)) = 1
        _IceSmoothness("Ice Smoothness", Range(0, 1)) = 0.9
        _IceCrackSmoothness("Ice Crack Smoothness", Range(0, 1)) = 0.2
        _IceNoiseSmoothness("Ice Noise Smoothness", Range(0, 1)) = 0.9
        [NoScaleOffset]_ParalaxMap("Ice Parallax Map", 2D) = "black" {}
        _ParalaxOffset("Ice Parallax Offset", Float) = 0
        _IceParallaxSteps("Ice Parallax Steps", Float) = 40
        _IceDepth("Ice Parallax Depth", Float) = -0.1
        _ParallaxFalloff("Ice Parallax Falloff", Range(0, 1)) = 0.6
        _IceParallaxNoiseScale("Ice Parallax Noise Scale", Float) = 3
        _IceParallaxNoiseMin("Ice Parallax Noise Remap Min", Range(0, 1)) = 0
        _IceParallaxNoiseMax("Ice Parallax Noise Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_CoverMaskA("Cover Mask (A)", 2D) = "white" {}
        _CoverMaskPower("Cover Mask Power", Range(0, 10)) = 1
        _Cover_Amount_Grow_Speed("Cover Amount Grow Speed", Range(0, 3)) = 3
        _Cover_Amount("Cover Amount", Range(0, 2)) = 2
        _Cover_Max_Angle("Cover Max Angle", Range(0.001, 90)) = 35
        _Cover_Min_Height("Cover Min Height", Float) = -10000
        _Cover_Min_Height_Blending("Cover Min Height Blending", Range(0, 500)) = 1
        _CoverHardness("Cover Hardness", Range(0, 10)) = 5
        _CoverBaseColor("Cover Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_CoverBaseColorMap("Cover Base Map", 2D) = "white" {}
        [ToggleUI]_CoverUsePlanarUV("Cover Use Planar UV", Float) = 1
        _CoverTilingOffset("Cover Tiling Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_CoverNormalMap("Cover Normal Map", 2D) = "bump" {}
        _CoverNormalScale("Cover Normal Scale", Range(0, 8)) = 1
        _CoverHeightMapMin("Cover Height Map Min", Float) = 0
        _CoverHeightMapMax("Cover Height Map Max", Float) = 1
        _CoverHeightMapOffset("Cover Height Map Offset", Float) = 0
        [NoScaleOffset]_CoverMaskMap("Cover Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
        _CoverMetallic("Cover Metallic", Range(0, 1)) = 1
        _CoverAORemapMin("Cover AO Remap Min", Range(0, 1)) = 0
        _CoverAORemapMax("Cover AO Remap Max", Range(0, 1)) = 1
        _CoverSmoothnessRemapMin("Cover Smoothness Remap Min", Range(0, 1)) = 0
        _CoverSmoothnessRemapMax("Cover Smoothness Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_DetailMap("Detail Map Base (R) Ny(G) Sm(B) Nx(A)", 2D) = "white" {}
        _DetailTilingOffset("Detail Tiling Offset", Vector) = (1, 1, 0, 0)
        _DetailAlbedoScale("Detail Albedo Scale", Range(0, 2)) = 0
        _DetailNormalScale("Detail Normal Scale", Range(0, 2)) = 0
        _DetailSmoothnessScale("Detail Smoothness Scale", Range(0, 2)) = 0
        _WetColor("Wet Color Vertex(R)", Color) = (0.7735849, 0.7735849, 0.7735849, 0)
        _WetSmoothness("Wet Smoothness Vertex(R)", Range(0, 1)) = 1
        [Toggle]_USEDYNAMICCOVERTSTATICMASKF("Use Dynamic Cover (T) Static Mask (F)", Float) = 1
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "Queue"="Geometry+0"
        }
        
        Pass
        {
            Name "Universal Forward"
            Tags 
            { 
                "LightMode" = "UniversalForward"
            }
           
            // Render State
            Blend One Zero, One Zero
            Cull Back
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
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON
            
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_BITANGENT_WS
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif
        
        
            #define SHADERPASS_FORWARD
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float4 _DeepColor;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float _IceNoiseScale;
            float _IceNoiseContrast;
            float _IceNoisePower;
            float _BaseNormalScale;
            float _NoiseNormalScale;
            float _BaseMetallic;
            float _BaseAO;
            float _IceSmoothness;
            float _IceCrackSmoothness;
            float _IceNoiseSmoothness;
            float _ParalaxOffset;
            float _IceParallaxSteps;
            float _IceDepth;
            float _ParallaxFalloff;
            float _IceParallaxNoiseScale;
            float _IceParallaxNoiseMin;
            float _IceParallaxNoiseMax;
            float _CoverMaskPower;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Amount;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float _CoverHardness;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
            float _CoverMetallic;
            float _CoverAORemapMin;
            float _CoverAORemapMax;
            float _CoverSmoothnessRemapMin;
            float _CoverSmoothnessRemapMax;
            float4 _DetailTilingOffset;
            float _DetailAlbedoScale;
            float _DetailNormalScale;
            float _DetailSmoothnessScale;
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_IceNoiseNormal); SAMPLER(sampler_IceNoiseNormal); float4 _IceNoiseNormal_TexelSize;
            TEXTURE2D(_ParalaxMap); SAMPLER(sampler_ParalaxMap); float4 _ParalaxMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_CD9C50D2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A42D1072_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }
            
            void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
            {
                Out = UV * Tiling + Offset;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
            {
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
            {
                float _Property_7E8A3125_Out_0 = Boolean_7ABB9909;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_C4659339_Out_0 = Vector4_2EBA7A3B;
                float _Split_73D91F75_R_1 = _Property_C4659339_Out_0[0];
                float _Split_73D91F75_G_2 = _Property_C4659339_Out_0[1];
                float _Split_73D91F75_B_3 = _Property_C4659339_Out_0[2];
                float _Split_73D91F75_A_4 = _Property_C4659339_Out_0[3];
                float _Divide_26B6AE80_Out_2;
                Unity_Divide_float(1, _Split_73D91F75_R_1, _Divide_26B6AE80_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_26B6AE80_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_6DD20118_Out_0 = float2(_Split_73D91F75_R_1, _Split_73D91F75_G_2);
                float2 _Vector2_AF5F407D_Out_0 = float2(_Split_73D91F75_B_3, _Split_73D91F75_A_4);
                float2 _TilingAndOffset_1DC08BD9_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6DD20118_Out_0, _Vector2_AF5F407D_Out_0, _TilingAndOffset_1DC08BD9_Out_3);
                float2 _Branch_4FEBA43B_Out_3;
                Unity_Branch_float2(_Property_7E8A3125_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_1DC08BD9_Out_3, _Branch_4FEBA43B_Out_3);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_4FEBA43B_Out_3);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                XZ_2 = _SampleTexture2D_AF934D9A_RGBA_0;
            }
            
            struct Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151
            {
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151(float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151 IN, out float4 XZ_2)
            {
                float _Property_7E8A3125_Out_0 = Boolean_7ABB9909;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_C4659339_Out_0 = Vector4_2EBA7A3B;
                float _Split_73D91F75_R_1 = _Property_C4659339_Out_0[0];
                float _Split_73D91F75_G_2 = _Property_C4659339_Out_0[1];
                float _Split_73D91F75_B_3 = _Property_C4659339_Out_0[2];
                float _Split_73D91F75_A_4 = _Property_C4659339_Out_0[3];
                float _Divide_26B6AE80_Out_2;
                Unity_Divide_float(1, _Split_73D91F75_R_1, _Divide_26B6AE80_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_26B6AE80_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_6DD20118_Out_0 = float2(_Split_73D91F75_R_1, _Split_73D91F75_G_2);
                float2 _Vector2_AF5F407D_Out_0 = float2(_Split_73D91F75_B_3, _Split_73D91F75_A_4);
                float2 _TilingAndOffset_1DC08BD9_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6DD20118_Out_0, _Vector2_AF5F407D_Out_0, _TilingAndOffset_1DC08BD9_Out_3);
                float2 _Branch_4FEBA43B_Out_3;
                Unity_Branch_float2(_Property_7E8A3125_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_1DC08BD9_Out_3, _Branch_4FEBA43B_Out_3);
                XZ_2 = (float4(_Branch_4FEBA43B_Out_3, 0.0, 1.0));
            }
            
            
            inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
            {
                return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
            }
            
            inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
            {
                return (1.0-t)*a + (t*b);
            }
            
            
            inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
            {
                float2 i = floor(uv);
                float2 f = frac(uv);
                f = f * f * (3.0 - 2.0 * f);
            
                uv = abs(frac(uv) - 0.5);
                float2 c0 = i + float2(0.0, 0.0);
                float2 c1 = i + float2(1.0, 0.0);
                float2 c2 = i + float2(0.0, 1.0);
                float2 c3 = i + float2(1.0, 1.0);
                float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                float r3 = Unity_SimpleNoise_RandomValue_float(c3);
            
                float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                return t;
            }
            void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
            {
                float t = 0.0;
            
                float freq = pow(2.0, float(0));
                float amp = pow(0.5, float(3-0));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                freq = pow(2.0, float(1));
                amp = pow(0.5, float(3-1));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                freq = pow(2.0, float(2));
                amp = pow(0.5, float(3-2));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                Out = t;
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            // 1ab7832f84992b571d2fa80a089d3a8e
            #include "Assets/NatureManufacture Assets/Object Shaders/NMParallaxLayers.hlsl"
            
            void Unity_Blend_Lighten_float4(float4 Base, float4 Blend, out float4 Out, float Opacity)
            {
                Out = max(Blend, Base);
                Out = lerp(Base, Out, Opacity);
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Contrast_float(float3 In, float Contrast, out float3 Out)
            {
                float midpoint = pow(0.5, 2.2);
                Out =  (In - midpoint) * Contrast + midpoint;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_SquareRoot_float4(float4 In, out float4 Out)
            {
                Out = sqrt(In);
            }
            
            void Unity_Sign_float(float In, out float Out)
            {
                Out = sign(In);
            }
            
            void Unity_Ceiling_float(float In, out float Out)
            {
                Out = ceil(In);
            }
            
            struct Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2
            {
            };
            
            void SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(float4 Color_9AA111D3, float Vector1_FBE622A2, float Vector1_8C15C351, Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 IN, out float3 OutVector4_1)
            {
                float4 _Property_90A62E4E_Out_0 = Color_9AA111D3;
                float4 _SquareRoot_51430F5B_Out_1;
                Unity_SquareRoot_float4(_Property_90A62E4E_Out_0, _SquareRoot_51430F5B_Out_1);
                float _Property_4C27E21E_Out_0 = Vector1_FBE622A2;
                float _Sign_2EB7E10D_Out_1;
                Unity_Sign_float(_Property_4C27E21E_Out_0, _Sign_2EB7E10D_Out_1);
                float _Add_29F1B1C0_Out_2;
                Unity_Add_float(_Sign_2EB7E10D_Out_1, 1, _Add_29F1B1C0_Out_2);
                float _Multiply_E5F6C023_Out_2;
                Unity_Multiply_float(_Add_29F1B1C0_Out_2, 0.5, _Multiply_E5F6C023_Out_2);
                float _Ceiling_85D24F96_Out_1;
                Unity_Ceiling_float(_Multiply_E5F6C023_Out_2, _Ceiling_85D24F96_Out_1);
                float _Property_33C740F_Out_0 = Vector1_8C15C351;
                float _Multiply_ED89DC5B_Out_2;
                Unity_Multiply_float(_Property_33C740F_Out_0, _Property_33C740F_Out_0, _Multiply_ED89DC5B_Out_2);
                float4 _Lerp_CA077B77_Out_3;
                Unity_Lerp_float4(_SquareRoot_51430F5B_Out_1, (_Ceiling_85D24F96_Out_1.xxxx), (_Multiply_ED89DC5B_Out_2.xxxx), _Lerp_CA077B77_Out_3);
                float4 _Multiply_9305D041_Out_2;
                Unity_Multiply_float(_Lerp_CA077B77_Out_3, _Lerp_CA077B77_Out_3, _Multiply_9305D041_Out_2);
                OutVector4_1 = (_Multiply_9305D041_Out_2.xyz);
            }
            
            void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_DotProduct_float2(float2 A, float2 B, out float Out)
            {
                Out = dot(A, B);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_SquareRoot_float(float In, out float Out)
            {
                Out = sqrt(In);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Normalize_float3(float3 In, out float3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
            {
                float _Property_EECC5191_Out_0 = Boolean_9FF42DF6;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_3C0E791E_Out_0 = Vector4_82674548;
                float _Split_BDB607D3_R_1 = _Property_3C0E791E_Out_0[0];
                float _Split_BDB607D3_G_2 = _Property_3C0E791E_Out_0[1];
                float _Split_BDB607D3_B_3 = _Property_3C0E791E_Out_0[2];
                float _Split_BDB607D3_A_4 = _Property_3C0E791E_Out_0[3];
                float _Divide_99B56138_Out_2;
                Unity_Divide_float(1, _Split_BDB607D3_R_1, _Divide_99B56138_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_99B56138_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_870D34BF_Out_0 = float2(_Split_BDB607D3_R_1, _Split_BDB607D3_G_2);
                float2 _Vector2_9D160F08_Out_0 = float2(_Split_BDB607D3_B_3, _Split_BDB607D3_A_4);
                float2 _TilingAndOffset_C775B36F_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_870D34BF_Out_0, _Vector2_9D160F08_Out_0, _TilingAndOffset_C775B36F_Out_3);
                float2 _Branch_F57F5E8_Out_3;
                Unity_Branch_float2(_Property_EECC5191_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_C775B36F_Out_3, _Branch_F57F5E8_Out_3);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_F57F5E8_Out_3);
                _SampleTexture2D_AF934D9A_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AF934D9A_RGBA_0);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float2 _Vector2_699A5DA1_Out_0 = float2(_SampleTexture2D_AF934D9A_R_4, _SampleTexture2D_AF934D9A_G_5);
                float3 _Sign_937BD7C4_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_937BD7C4_Out_1);
                float _Split_A88C5CBA_R_1 = _Sign_937BD7C4_Out_1[0];
                float _Split_A88C5CBA_G_2 = _Sign_937BD7C4_Out_1[1];
                float _Split_A88C5CBA_B_3 = _Sign_937BD7C4_Out_1[2];
                float _Split_A88C5CBA_A_4 = 0;
                float2 _Vector2_DC7A07A_Out_0 = float2(_Split_A88C5CBA_G_2, 1);
                float2 _Multiply_5A3A785C_Out_2;
                Unity_Multiply_float(_Vector2_699A5DA1_Out_0, _Vector2_DC7A07A_Out_0, _Multiply_5A3A785C_Out_2);
                float _Split_CE0AB7C6_R_1 = IN.WorldSpaceNormal[0];
                float _Split_CE0AB7C6_G_2 = IN.WorldSpaceNormal[1];
                float _Split_CE0AB7C6_B_3 = IN.WorldSpaceNormal[2];
                float _Split_CE0AB7C6_A_4 = 0;
                float2 _Vector2_D40FA1D3_Out_0 = float2(_Split_CE0AB7C6_R_1, _Split_CE0AB7C6_B_3);
                float2 _Add_E4BBD98D_Out_2;
                Unity_Add_float2(_Multiply_5A3A785C_Out_2, _Vector2_D40FA1D3_Out_0, _Add_E4BBD98D_Out_2);
                float _Split_1D7F6EE9_R_1 = _Add_E4BBD98D_Out_2[0];
                float _Split_1D7F6EE9_G_2 = _Add_E4BBD98D_Out_2[1];
                float _Split_1D7F6EE9_B_3 = 0;
                float _Split_1D7F6EE9_A_4 = 0;
                float _Multiply_D1C95945_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_B_6, _Split_CE0AB7C6_G_2, _Multiply_D1C95945_Out_2);
                float3 _Vector3_CB17D4AB_Out_0 = float3(_Split_1D7F6EE9_R_1, _Multiply_D1C95945_Out_2, _Split_1D7F6EE9_G_2);
                float3x3 Transform_D163BAD_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_D163BAD_Out_1 = TransformWorldToTangent(_Vector3_CB17D4AB_Out_0.xyz, Transform_D163BAD_tangentTransform_World);
                float3 _Normalize_49BB8375_Out_1;
                Unity_Normalize_float3(_Transform_D163BAD_Out_1, _Normalize_49BB8375_Out_1);
                float3 _Branch_CB8BD7A6_Out_3;
                Unity_Branch_float3(_Property_EECC5191_Out_0, _Normalize_49BB8375_Out_1, (_SampleTexture2D_AF934D9A_RGBA_0.xyz), _Branch_CB8BD7A6_Out_3);
                XZ_2 = (float4(_Branch_CB8BD7A6_Out_3, 1.0));
            }
            
            void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
            {
                Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            struct Bindings_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a
            {
            };
            
            void SG_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a(float Vector1_32317166, float Vector1_FBE622A2, float Vector1_8C15C351, Bindings_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a IN, out float SmoothnessOverlay_1)
            {
                float _Property_B2B0AC51_Out_0 = Vector1_32317166;
                float _Property_4C27E21E_Out_0 = Vector1_FBE622A2;
                float _Sign_2EB7E10D_Out_1;
                Unity_Sign_float(_Property_4C27E21E_Out_0, _Sign_2EB7E10D_Out_1);
                float _Add_29F1B1C0_Out_2;
                Unity_Add_float(_Sign_2EB7E10D_Out_1, 1, _Add_29F1B1C0_Out_2);
                float _Multiply_E5F6C023_Out_2;
                Unity_Multiply_float(_Add_29F1B1C0_Out_2, 0.5, _Multiply_E5F6C023_Out_2);
                float _Ceiling_85D24F96_Out_1;
                Unity_Ceiling_float(_Multiply_E5F6C023_Out_2, _Ceiling_85D24F96_Out_1);
                float _Property_33C740F_Out_0 = Vector1_8C15C351;
                float _Lerp_CA077B77_Out_3;
                Unity_Lerp_float(_Property_B2B0AC51_Out_0, _Ceiling_85D24F96_Out_1, _Property_33C740F_Out_0, _Lerp_CA077B77_Out_3);
                SmoothnessOverlay_1 = _Lerp_CA077B77_Out_3;
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceBiTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceViewDirection;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 AbsoluteWorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
            };
            
            struct SurfaceDescription
            {
                float3 Albedo;
                float3 Normal;
                float3 Emission;
                float Metallic;
                float Smoothness;
                float Occlusion;
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3E4B16C8_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F2A4C04A_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_605BEBB1;
                _PlanarNM_605BEBB1.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_605BEBB1.uv0 = IN.uv0;
                float4 _PlanarNM_605BEBB1_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNM_605BEBB1, _PlanarNM_605BEBB1_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F69A7540_Out_0 = _IceParallaxSteps;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151 _PlanarNMparallax_19C7D294;
                _PlanarNMparallax_19C7D294.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMparallax_19C7D294.uv0 = IN.uv0;
                float4 _PlanarNMparallax_19C7D294_XZ_2;
                SG_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151(_Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMparallax_19C7D294, _PlanarNMparallax_19C7D294_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_584447FF_Out_0 = _ParalaxOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_25AD48E5_Out_0 = _IceParallaxNoiseMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_98575B71_Out_0 = _IceParallaxNoiseMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_16DB2C3A_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_16DB2C3A_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_16DB2C3A_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_16DB2C3A_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_BE79C1A8_Out_0 = float2(_Split_16DB2C3A_R_1, _Split_16DB2C3A_B_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_543B17EA_Out_0 = _IceParallaxNoiseScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SimpleNoise_CCF200D9_Out_2;
                Unity_SimpleNoise_float(_Vector2_BE79C1A8_Out_0, _Property_543B17EA_Out_0, _SimpleNoise_CCF200D9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_5C49F379_Out_3;
                Unity_Lerp_float(_Property_25AD48E5_Out_0, _Property_98575B71_Out_0, _SimpleNoise_CCF200D9_Out_2, _Lerp_5C49F379_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_A34AA065_Out_3;
                Unity_Lerp_float(_Property_584447FF_Out_0, 0, _Lerp_5C49F379_Out_3, _Lerp_A34AA065_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_36F6A6D0_Out_0 = _IceDepth;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3x3 Transform_D9CFEC5_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_D9CFEC5_Out_1 = TransformWorldToTangent(IN.WorldSpaceViewDirection.xyz, Transform_D9CFEC5_tangentTransform_World);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_39D230AF_Out_0 = _ParallaxFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_ED48CB71_Out_3;
                Unity_Lerp_float(_Property_39D230AF_Out_0, 0, _Lerp_5C49F379_Out_3, _Lerp_ED48CB71_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _CustomFunction_92A39E95_Out_2;
                ParallaxLayers_float(_Property_F69A7540_Out_0, (_PlanarNMparallax_19C7D294_XZ_2.xy), _Lerp_A34AA065_Out_3, _Property_36F6A6D0_Out_0, _Transform_D9CFEC5_Out_1, IN.WorldSpaceViewDirection, _Lerp_ED48CB71_Out_3, _Property_F2A4C04A_Out_0, _CustomFunction_92A39E95_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Blend_F08AFA54_Out_2;
                Unity_Blend_Lighten_float4(_PlanarNM_605BEBB1_XZ_2, _CustomFunction_92A39E95_Out_2, _Blend_F08AFA54_Out_2, _Property_39D230AF_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_C4180B07_Out_0 = _DeepColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2896096E_Out_0 = _IceNoiseScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SimpleNoise_608BDE5D_Out_2;
                Unity_SimpleNoise_float(_Vector2_BE79C1A8_Out_0, _Property_2896096E_Out_0, _SimpleNoise_608BDE5D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_39A6A18_Out_1;
                Unity_Absolute_float(_SimpleNoise_608BDE5D_Out_2, _Absolute_39A6A18_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F52DBFE9_Out_0 = _IceNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Power_3A1C69E3_Out_2;
                Unity_Power_float(_Absolute_39A6A18_Out_1, _Property_F52DBFE9_Out_0, _Power_3A1C69E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C2BBB8DB_Out_0 = _IceNoiseContrast;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Contrast_D1EA0699_Out_2;
                Unity_Contrast_float((_Power_3A1C69E3_Out_2.xxx), _Property_C2BBB8DB_Out_0, _Contrast_D1EA0699_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9D04AA67_R_1 = _Contrast_D1EA0699_Out_2[0];
                float _Split_9D04AA67_G_2 = _Contrast_D1EA0699_Out_2[1];
                float _Split_9D04AA67_B_3 = _Contrast_D1EA0699_Out_2[2];
                float _Split_9D04AA67_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_7C8D44C6_Out_3;
                Unity_Clamp_float(_Split_9D04AA67_R_1, 0, 1, _Clamp_7C8D44C6_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Lerp_10B48734_Out_3;
                Unity_Lerp_float4(_Blend_F08AFA54_Out_2, _Property_C4180B07_Out_0, (_Clamp_7C8D44C6_Out_3.xxxx), _Lerp_10B48734_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3D23ECB5_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_3B5A4F3A_Out_2;
                Unity_Multiply_float(_Lerp_10B48734_Out_3, _Property_3D23ECB5_Out_0, _Multiply_3B5A4F3A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_FC905A02_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_66FEB2D6_R_1 = _Property_FC905A02_Out_0[0];
                float _Split_66FEB2D6_G_2 = _Property_FC905A02_Out_0[1];
                float _Split_66FEB2D6_B_3 = _Property_FC905A02_Out_0[2];
                float _Split_66FEB2D6_A_4 = _Property_FC905A02_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_2C65450F_Out_0 = float2(_Split_66FEB2D6_R_1, _Split_66FEB2D6_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_20821B1B_Out_0 = float2(_Split_66FEB2D6_B_3, _Split_66FEB2D6_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_AFDF49A5_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_2C65450F_Out_0, _Vector2_20821B1B_Out_0, _TilingAndOffset_AFDF49A5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_CD9C50D2_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_AFDF49A5_Out_3);
                float _SampleTexture2D_CD9C50D2_R_4 = _SampleTexture2D_CD9C50D2_RGBA_0.r;
                float _SampleTexture2D_CD9C50D2_G_5 = _SampleTexture2D_CD9C50D2_RGBA_0.g;
                float _SampleTexture2D_CD9C50D2_B_6 = _SampleTexture2D_CD9C50D2_RGBA_0.b;
                float _SampleTexture2D_CD9C50D2_A_7 = _SampleTexture2D_CD9C50D2_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_6CEB2199_Out_2;
                Unity_Multiply_float(_SampleTexture2D_CD9C50D2_R_4, 2, _Multiply_6CEB2199_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_81546154_Out_2;
                Unity_Add_float(_Multiply_6CEB2199_Out_2, -1, _Add_81546154_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2152BC92_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_4FF44BF6_Out_2;
                Unity_Multiply_float(_Add_81546154_Out_2, _Property_2152BC92_Out_0, _Multiply_4FF44BF6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_44A6B3E6_Out_1;
                Unity_Saturate_float(_Multiply_4FF44BF6_Out_2, _Saturate_44A6B3E6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_252B9168_Out_1;
                Unity_Absolute_float(_Saturate_44A6B3E6_Out_1, _Absolute_252B9168_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_DC11EFE2;
                float3 _BlendOverlayBaseColor_DC11EFE2_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_3B5A4F3A_Out_2, _Add_81546154_Out_2, _Absolute_252B9168_Out_1, _BlendOverlayBaseColor_DC11EFE2, _BlendOverlayBaseColor_DC11EFE2_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_E0773BA3_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6388FCB5_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_37241974;
                _PlanarNM_37241974.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_37241974.uv0 = IN.uv0;
                float4 _PlanarNM_37241974_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNM_37241974, _PlanarNM_37241974_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_AF2EEB1D_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_64C7F396_Out_2;
                Unity_Multiply_float(_PlanarNM_37241974_XZ_2, _Property_AF2EEB1D_Out_0, _Multiply_64C7F396_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_23C9E59F_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_A42D1072_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_23C9E59F_Out_0.xy));
                float _SampleTexture2D_A42D1072_R_4 = _SampleTexture2D_A42D1072_RGBA_0.r;
                float _SampleTexture2D_A42D1072_G_5 = _SampleTexture2D_A42D1072_RGBA_0.g;
                float _SampleTexture2D_A42D1072_B_6 = _SampleTexture2D_A42D1072_RGBA_0.b;
                float _SampleTexture2D_A42D1072_A_7 = _SampleTexture2D_A42D1072_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_23BACCE9_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_E1E6CA0C_Out_2;
                Unity_Multiply_float(_SampleTexture2D_A42D1072_A_7, _Property_23BACCE9_Out_0, _Multiply_E1E6CA0C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_E47EFF9E_Out_3;
                Unity_Clamp_float(_Multiply_E1E6CA0C_Out_2, 0, 1, _Clamp_E47EFF9E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Clamp_93A41266_Out_3;
                Unity_Clamp_float4(IN.VertexColor, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_93A41266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A30F99_R_1 = _Clamp_93A41266_Out_3[0];
                float _Split_A30F99_G_2 = _Clamp_93A41266_Out_3[1];
                float _Split_A30F99_B_3 = _Clamp_93A41266_Out_3[2];
                float _Split_A30F99_A_4 = _Clamp_93A41266_Out_3[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_D25079B9_Out_0 = float2(_SampleTexture2D_CD9C50D2_A_7, _SampleTexture2D_CD9C50D2_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Multiply_A6D263CC_Out_2;
                Unity_Multiply_float(_Vector2_D25079B9_Out_0, float2(2, 2), _Multiply_A6D263CC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_A94F92F2_Out_2;
                Unity_Add_float2(_Multiply_A6D263CC_Out_2, float2(-1, -1), _Add_A94F92F2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_5A04D61A_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Multiply_E3BBD5A0_Out_2;
                Unity_Multiply_float(_Add_A94F92F2_Out_2, (_Property_5A04D61A_Out_0.xx), _Multiply_E3BBD5A0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_3BC0AA96_R_1 = _Multiply_E3BBD5A0_Out_2[0];
                float _Split_3BC0AA96_G_2 = _Multiply_E3BBD5A0_Out_2[1];
                float _Split_3BC0AA96_B_3 = 0;
                float _Split_3BC0AA96_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _DotProduct_9FB0B73C_Out_2;
                Unity_DotProduct_float2(_Multiply_E3BBD5A0_Out_2, _Multiply_E3BBD5A0_Out_2, _DotProduct_9FB0B73C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_3C8C4A9B_Out_1;
                Unity_Saturate_float(_DotProduct_9FB0B73C_Out_2, _Saturate_3C8C4A9B_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_E0A2EC16_Out_1;
                Unity_OneMinus_float(_Saturate_3C8C4A9B_Out_1, _OneMinus_E0A2EC16_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SquareRoot_7D6FC55F_Out_1;
                Unity_SquareRoot_float(_OneMinus_E0A2EC16_Out_1, _SquareRoot_7D6FC55F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_408E9F99_Out_0 = float3(_Split_3BC0AA96_R_1, _Split_3BC0AA96_G_2, _SquareRoot_7D6FC55F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_F0D9C40B;
                _PlanarNMn_F0D9C40B.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_F0D9C40B.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_F0D9C40B.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_F0D9C40B.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_F0D9C40B.uv0 = IN.uv0;
                float4 _PlanarNMn_F0D9C40B_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMn_F0D9C40B, _PlanarNMn_F0D9C40B_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_1CABD952_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_EDF1EB8B_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_F0D9C40B_XZ_2.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_B7F72910;
                _PlanarNMn_B7F72910.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_B7F72910.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_B7F72910.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_B7F72910.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_B7F72910.uv0 = IN.uv0;
                float4 _PlanarNMn_B7F72910_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_IceNoiseNormal, sampler_IceNoiseNormal), _IceNoiseNormal_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMn_B7F72910, _PlanarNMn_B7F72910_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_3E79A67D_Out_0 = _NoiseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_DC5D8477_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_B7F72910_XZ_2.xyz), _Property_3E79A67D_Out_0, _NormalStrength_DC5D8477_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_13B2C2D_Out_3;
                Unity_Lerp_float3(_NormalStrength_EDF1EB8B_Out_2, _NormalStrength_DC5D8477_Out_2, (_Clamp_7C8D44C6_Out_3.xxx), _Lerp_13B2C2D_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalBlend_24C86B99_Out_2;
                Unity_NormalBlend_float(_Vector3_408E9F99_Out_0, _Lerp_13B2C2D_Out_3, _NormalBlend_24C86B99_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_82A01385;
                _PlanarNMn_82A01385.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_82A01385.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_82A01385.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_82A01385.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_82A01385.uv0 = IN.uv0;
                float4 _PlanarNMn_82A01385_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNMn_82A01385, _PlanarNMn_82A01385_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2BC6CE93_Out_0 = _CoverNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_EE9C3A89_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_82A01385_XZ_2.xyz), _Property_2BC6CE93_Out_0, _NormalStrength_EE9C3A89_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_285FA03B_R_1 = IN.WorldSpaceNormal[0];
                float _Split_285FA03B_G_2 = IN.WorldSpaceNormal[1];
                float _Split_285FA03B_B_3 = IN.WorldSpaceNormal[2];
                float _Split_285FA03B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_A78EDC1C_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9F8A8080_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_F2912DD5_Out_2;
                Unity_Subtract_float(4, _Property_9F8A8080_Out_0, _Subtract_F2912DD5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_D14A542B_Out_2;
                Unity_Divide_float(_Property_A78EDC1C_Out_0, _Subtract_F2912DD5_Out_2, _Divide_D14A542B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_CBDEAEC6_Out_1;
                Unity_Absolute_float(_Divide_D14A542B_Out_2, _Absolute_CBDEAEC6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_468546B2_Out_2;
                Unity_Power_float(_Absolute_CBDEAEC6_Out_1, _Subtract_F2912DD5_Out_2, _Power_468546B2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_505BD7CB_Out_3;
                Unity_Clamp_float(_Power_468546B2_Out_2, 0, 2, _Clamp_505BD7CB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_C557E9AF_Out_2;
                Unity_Multiply_float(_Split_285FA03B_G_2, _Clamp_505BD7CB_Out_3, _Multiply_C557E9AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_AAEFC124_Out_1;
                Unity_Saturate_float(_Multiply_C557E9AF_Out_2, _Saturate_AAEFC124_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_FE0E6938_Out_3;
                Unity_Clamp_float(_Split_285FA03B_G_2, 0, 0.9999, _Clamp_FE0E6938_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9FAF9E79_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_C024499C_Out_2;
                Unity_Divide_float(_Property_9FAF9E79_Out_0, 45, _Divide_C024499C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_819C6AF2_Out_1;
                Unity_OneMinus_float(_Divide_C024499C_Out_2, _OneMinus_819C6AF2_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_E0C6446E_Out_2;
                Unity_Subtract_float(_Clamp_FE0E6938_Out_3, _OneMinus_819C6AF2_Out_1, _Subtract_E0C6446E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_9DD83AC8_Out_3;
                Unity_Clamp_float(_Subtract_E0C6446E_Out_2, 0, 2, _Clamp_9DD83AC8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_FA29401D_Out_2;
                Unity_Divide_float(1, _Divide_C024499C_Out_2, _Divide_FA29401D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_4D0D7B0_Out_2;
                Unity_Multiply_float(_Clamp_9DD83AC8_Out_3, _Divide_FA29401D_Out_2, _Multiply_4D0D7B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_128CA3C3_Out_1;
                Unity_Absolute_float(_Multiply_4D0D7B0_Out_2, _Absolute_128CA3C3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_CFA12E7D_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_5ED343D8_Out_2;
                Unity_Power_float(_Absolute_128CA3C3_Out_1, _Property_CFA12E7D_Out_0, _Power_5ED343D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_3BC73AD4_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_5124E5F6_Out_1;
                Unity_OneMinus_float(_Property_3BC73AD4_Out_0, _OneMinus_5124E5F6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_2735CEFA_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_2735CEFA_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_2735CEFA_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_2735CEFA_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_ED205FBF_Out_2;
                Unity_Add_float(_OneMinus_5124E5F6_Out_1, _Split_2735CEFA_G_2, _Add_ED205FBF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_752AF7A2_Out_2;
                Unity_Add_float(_Add_ED205FBF_Out_2, 1, _Add_752AF7A2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_E090F386_Out_3;
                Unity_Clamp_float(_Add_752AF7A2_Out_2, 0, 1, _Clamp_E090F386_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_73B1AD10_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_331D8064_Out_2;
                Unity_Add_float(_Add_ED205FBF_Out_2, _Property_73B1AD10_Out_0, _Add_331D8064_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_CB58FE2E_Out_2;
                Unity_Divide_float(_Add_331D8064_Out_2, _Add_ED205FBF_Out_2, _Divide_CB58FE2E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1ABEFCE6_Out_1;
                Unity_OneMinus_float(_Divide_CB58FE2E_Out_2, _OneMinus_1ABEFCE6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_8F137BF7_Out_2;
                Unity_Add_float(_OneMinus_1ABEFCE6_Out_1, -0.5, _Add_8F137BF7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_35395974_Out_3;
                Unity_Clamp_float(_Add_8F137BF7_Out_2, 0, 1, _Clamp_35395974_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DC8DD517_Out_2;
                Unity_Add_float(_Clamp_E090F386_Out_3, _Clamp_35395974_Out_3, _Add_DC8DD517_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_978A71EF_Out_3;
                Unity_Clamp_float(_Add_DC8DD517_Out_2, 0, 1, _Clamp_978A71EF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_85C9E9EE_Out_2;
                Unity_Multiply_float(_Power_5ED343D8_Out_2, _Clamp_978A71EF_Out_3, _Multiply_85C9E9EE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D14C5FA5_Out_2;
                Unity_Multiply_float(_Saturate_AAEFC124_Out_1, _Multiply_85C9E9EE_Out_2, _Multiply_D14C5FA5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_B3376A42_Out_3;
                Unity_Lerp_float3(_NormalBlend_24C86B99_Out_2, _NormalStrength_EE9C3A89_Out_2, (_Multiply_D14C5FA5_Out_2.xxx), _Lerp_B3376A42_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_D1A2C0A3_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_D1A2C0A3_Out_1 = mul(Transform_D1A2C0A3_transposeTangent, _Lerp_B3376A42_Out_3.xyz).xyz;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_B0D440A_R_1 = _Transform_D1A2C0A3_Out_1[0];
                float _Split_B0D440A_G_2 = _Transform_D1A2C0A3_Out_1[1];
                float _Split_B0D440A_B_3 = _Transform_D1A2C0A3_Out_1[2];
                float _Split_B0D440A_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_730C1F53_Out_2;
                Unity_Multiply_float(_Split_B0D440A_G_2, _Clamp_505BD7CB_Out_3, _Multiply_730C1F53_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_B2B3901D_Out_2;
                Unity_Multiply_float(_Clamp_505BD7CB_Out_3, _Property_CFA12E7D_Out_0, _Multiply_B2B3901D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_A7C78B4E_Out_2;
                Unity_Multiply_float(_Multiply_B2B3901D_Out_2, _Multiply_85C9E9EE_Out_2, _Multiply_A7C78B4E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_A9771D5F_Out_2;
                Unity_Multiply_float(_Multiply_730C1F53_Out_2, _Multiply_A7C78B4E_Out_2, _Multiply_A9771D5F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_1C1C26F9;
                _PlanarNM_1C1C26F9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_1C1C26F9.uv0 = IN.uv0;
                float4 _PlanarNM_1C1C26F9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNM_1C1C26F9, _PlanarNM_1C1C26F9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_C5FA0079_R_1 = _PlanarNM_1C1C26F9_XZ_2[0];
                float _Split_C5FA0079_G_2 = _PlanarNM_1C1C26F9_XZ_2[1];
                float _Split_C5FA0079_B_3 = _PlanarNM_1C1C26F9_XZ_2[2];
                float _Split_C5FA0079_A_4 = _PlanarNM_1C1C26F9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_79C0622E_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_F9B7976A_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_2075ED8D_Out_0 = float2(_Property_79C0622E_Out_0, _Property_F9B7976A_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_39A9ADEC_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_DFDDD509_Out_2;
                Unity_Add_float2(_Vector2_2075ED8D_Out_0, (_Property_39A9ADEC_Out_0.xx), _Add_DFDDD509_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_64922366_Out_3;
                Unity_Remap_float(_Split_C5FA0079_B_3, float2 (0, 1), _Add_DFDDD509_Out_2, _Remap_64922366_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5DF35CED_Out_2;
                Unity_Multiply_float(_Multiply_A9771D5F_Out_2, _Remap_64922366_Out_3, _Multiply_5DF35CED_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_46650FF2_Out_2;
                Unity_Multiply_float(_Split_A30F99_G_2, _Multiply_5DF35CED_Out_2, _Multiply_46650FF2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_A6088ECC_Out_1;
                Unity_Saturate_float(_Multiply_46650FF2_Out_2, _Saturate_A6088ECC_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_FDFD4BAD_Out_2;
                Unity_Multiply_float(_Clamp_E47EFF9E_Out_3, _Saturate_A6088ECC_Out_1, _Multiply_FDFD4BAD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_6DA1DCFE_Out_3;
                Unity_Clamp_float(_Multiply_FDFD4BAD_Out_2, 0, 1, _Clamp_6DA1DCFE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_11641B3F_Out_0 = _Clamp_6DA1DCFE_Out_3;
                #else
                float _UseDynamicCoverTStaticMaskF_11641B3F_Out_0 = _Clamp_E47EFF9E_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_8BDA8462_Out_3;
                Unity_Clamp_float(_UseDynamicCoverTStaticMaskF_11641B3F_Out_0, 0, 1, _Clamp_8BDA8462_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_6387F1BD_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_DC11EFE2_OutVector4_1, (_Multiply_64C7F396_Out_2.xyz), (_Clamp_8BDA8462_Out_3.xxx), _Lerp_6387F1BD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_FCA5654_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_8F3F0743_Out_2;
                Unity_Multiply_float((_Property_FCA5654_Out_0.xyz), _Lerp_6387F1BD_Out_3, _Multiply_8F3F0743_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_3E465E6D_Out_1;
                Unity_OneMinus_float(_Split_A30F99_R_1, _OneMinus_3E465E6D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_D3906CE2_Out_3;
                Unity_Lerp_float3(_Lerp_6387F1BD_Out_3, _Multiply_8F3F0743_Out_2, (_OneMinus_3E465E6D_Out_1.xxx), _Lerp_D3906CE2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_CC69B645_Out_3;
                Unity_Lerp_float3(_NormalBlend_24C86B99_Out_2, _NormalStrength_EE9C3A89_Out_2, (_Clamp_8BDA8462_Out_3.xxx), _Lerp_CC69B645_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_25A8FF3A_Out_0 = _BaseMetallic;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_DF6FBA39_Out_0 = _BaseAO;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_3A018C8A_Out_0 = _IceSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_79AA31A5_Out_0 = _IceCrackSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_C1739F75;
                _PlanarNM_C1739F75.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_C1739F75.uv0 = IN.uv0;
                float4 _PlanarNM_C1739F75_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_ParalaxMap, sampler_ParalaxMap), _ParalaxMap_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNM_C1739F75, _PlanarNM_C1739F75_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Lerp_1EAE3EFB_Out_3;
                Unity_Lerp_float4((_Property_3A018C8A_Out_0.xxxx), (_Property_79AA31A5_Out_0.xxxx), _PlanarNM_C1739F75_XZ_2, _Lerp_1EAE3EFB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_8EE78501_Out_0 = _IceNoiseSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Lerp_3267F51B_Out_3;
                Unity_Lerp_float4(_Lerp_1EAE3EFB_Out_3, (_Property_8EE78501_Out_0.xxxx), (_Clamp_7C8D44C6_Out_3.xxxx), _Lerp_3267F51B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_55B1F0BE_Out_2;
                Unity_Multiply_float(_SampleTexture2D_CD9C50D2_B_6, 2, _Multiply_55B1F0BE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_AE24F590_Out_2;
                Unity_Add_float(_Multiply_55B1F0BE_Out_2, -1, _Add_AE24F590_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_B5AB31DA_Out_0 = _DetailSmoothnessScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_C0EAB2EE_Out_2;
                Unity_Multiply_float(_Add_AE24F590_Out_2, _Property_B5AB31DA_Out_0, _Multiply_C0EAB2EE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_1F246CE5_Out_1;
                Unity_Saturate_float(_Multiply_C0EAB2EE_Out_2, _Saturate_1F246CE5_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_95405FDB_Out_1;
                Unity_Absolute_float(_Saturate_1F246CE5_Out_1, _Absolute_95405FDB_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a _BlendOverlayDetailSmoothness_3B17247C;
                float _BlendOverlayDetailSmoothness_3B17247C_SmoothnessOverlay_1;
                SG_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a((_Lerp_3267F51B_Out_3).x, _Add_AE24F590_Out_2, _Absolute_95405FDB_Out_1, _BlendOverlayDetailSmoothness_3B17247C, _BlendOverlayDetailSmoothness_3B17247C_SmoothnessOverlay_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_F6661092_Out_1;
                Unity_Saturate_float(_BlendOverlayDetailSmoothness_3B17247C_SmoothnessOverlay_1, _Saturate_F6661092_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_FEF1FB88_Out_0 = float3(_Property_25A8FF3A_Out_0, _Property_DF6FBA39_Out_0, _Saturate_F6661092_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_88D7F675_Out_0 = _CoverMetallic;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_ED7647AC_Out_2;
                Unity_Multiply_float(_Split_C5FA0079_R_1, _Property_88D7F675_Out_0, _Multiply_ED7647AC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_559BF471_Out_0 = _CoverAORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C5C18557_Out_0 = _CoverAORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_BB54B900_Out_0 = float2(_Property_559BF471_Out_0, _Property_C5C18557_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_91B89F26_Out_3;
                Unity_Remap_float(_Split_C5FA0079_G_2, float2 (0, 1), _Vector2_BB54B900_Out_0, _Remap_91B89F26_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_D4159FAC_Out_0 = _CoverSmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_60E25749_Out_0 = _CoverSmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_3EBCF04C_Out_0 = float2(_Property_D4159FAC_Out_0, _Property_60E25749_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_3544B0FC_Out_3;
                Unity_Remap_float(_Split_C5FA0079_A_4, float2 (0, 1), _Vector2_3EBCF04C_Out_0, _Remap_3544B0FC_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_4B858D29_Out_0 = float3(_Multiply_ED7647AC_Out_2, _Remap_91B89F26_Out_3, _Remap_3544B0FC_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_6B5C6348_Out_3;
                Unity_Lerp_float3(_Vector3_FEF1FB88_Out_0, _Vector3_4B858D29_Out_0, (_Clamp_8BDA8462_Out_3.xxx), _Lerp_6B5C6348_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_BF192904_R_1 = _Lerp_6B5C6348_Out_3[0];
                float _Split_BF192904_G_2 = _Lerp_6B5C6348_Out_3[1];
                float _Split_BF192904_B_3 = _Lerp_6B5C6348_Out_3[2];
                float _Split_BF192904_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_18CCC244_Out_0 = _WetSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_F94D351C_Out_3;
                Unity_Lerp_float(_Split_BF192904_B_3, _Property_18CCC244_Out_0, _OneMinus_3E465E6D_Out_1, _Lerp_F94D351C_Out_3);
                #endif
                surface.Albedo = _Lerp_D3906CE2_Out_3;
                surface.Normal = _Lerp_CC69B645_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Metallic = _Split_BF192904_R_1;
                surface.Smoothness = _Lerp_F94D351C_Out_3;
                surface.Occlusion = _Split_BF192904_G_2;
                surface.Alpha = 1;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0 : TEXCOORD0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv1 : TEXCOORD1;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_Position;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 viewDirectionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 bitangentWS;
                #endif
                #if defined(LIGHTMAP_ON)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 lightmapUV;
                #endif
                #endif
                #if !defined(LIGHTMAP_ON)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 sh;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 fogFactorAndVertexLight;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 shadowCoord;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
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
                float3 interp05 : TEXCOORD5;
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
                PackedVaryings output;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.color;
                output.interp05.xyz = input.viewDirectionWS;
                output.interp06.xyz = input.bitangentWS;
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
                Varyings output;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.color = input.interp04.xyzw;
                output.viewDirectionWS = input.interp05.xyz;
                output.bitangentWS = input.interp06.xyz;
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
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            input.normalWS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceTangent =           input.tangentWS.xyz;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceBiTangent =         input.bitangentWS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
            #endif
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
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
            Blend One Zero, One Zero
            Cull Back
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
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON
            
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            #define SHADERPASS_SHADOWCASTER
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float4 _DeepColor;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float _IceNoiseScale;
            float _IceNoiseContrast;
            float _IceNoisePower;
            float _BaseNormalScale;
            float _NoiseNormalScale;
            float _BaseMetallic;
            float _BaseAO;
            float _IceSmoothness;
            float _IceCrackSmoothness;
            float _IceNoiseSmoothness;
            float _ParalaxOffset;
            float _IceParallaxSteps;
            float _IceDepth;
            float _ParallaxFalloff;
            float _IceParallaxNoiseScale;
            float _IceParallaxNoiseMin;
            float _IceParallaxNoiseMax;
            float _CoverMaskPower;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Amount;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float _CoverHardness;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
            float _CoverMetallic;
            float _CoverAORemapMin;
            float _CoverAORemapMax;
            float _CoverSmoothnessRemapMin;
            float _CoverSmoothnessRemapMax;
            float4 _DetailTilingOffset;
            float _DetailAlbedoScale;
            float _DetailNormalScale;
            float _DetailSmoothnessScale;
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_IceNoiseNormal); SAMPLER(sampler_IceNoiseNormal); float4 _IceNoiseNormal_TexelSize;
            TEXTURE2D(_ParalaxMap); SAMPLER(sampler_ParalaxMap); float4 _ParalaxMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
        
            // Graph Functions
            // GraphFunctions: <None>
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                surface.Alpha = 1;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_Position;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                output.positionCS = input.positionCS;
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
                Varyings output;
                output.positionCS = input.positionCS;
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
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
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
            Blend One Zero, One Zero
            Cull Back
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
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON
            
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            #define SHADERPASS_DEPTHONLY
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float4 _DeepColor;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float _IceNoiseScale;
            float _IceNoiseContrast;
            float _IceNoisePower;
            float _BaseNormalScale;
            float _NoiseNormalScale;
            float _BaseMetallic;
            float _BaseAO;
            float _IceSmoothness;
            float _IceCrackSmoothness;
            float _IceNoiseSmoothness;
            float _ParalaxOffset;
            float _IceParallaxSteps;
            float _IceDepth;
            float _ParallaxFalloff;
            float _IceParallaxNoiseScale;
            float _IceParallaxNoiseMin;
            float _IceParallaxNoiseMax;
            float _CoverMaskPower;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Amount;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float _CoverHardness;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
            float _CoverMetallic;
            float _CoverAORemapMin;
            float _CoverAORemapMax;
            float _CoverSmoothnessRemapMin;
            float _CoverSmoothnessRemapMax;
            float4 _DetailTilingOffset;
            float _DetailAlbedoScale;
            float _DetailNormalScale;
            float _DetailSmoothnessScale;
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_IceNoiseNormal); SAMPLER(sampler_IceNoiseNormal); float4 _IceNoiseNormal_TexelSize;
            TEXTURE2D(_ParalaxMap); SAMPLER(sampler_ParalaxMap); float4 _ParalaxMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
        
            // Graph Functions
            // GraphFunctions: <None>
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                surface.Alpha = 1;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_Position;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                output.positionCS = input.positionCS;
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
                Varyings output;
                output.positionCS = input.positionCS;
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
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
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
            Blend One Zero, One Zero
            Cull Back
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
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON
            
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_BITANGENT_WS
        #endif
        
        
        
        
            #define SHADERPASS_META
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float4 _DeepColor;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float _IceNoiseScale;
            float _IceNoiseContrast;
            float _IceNoisePower;
            float _BaseNormalScale;
            float _NoiseNormalScale;
            float _BaseMetallic;
            float _BaseAO;
            float _IceSmoothness;
            float _IceCrackSmoothness;
            float _IceNoiseSmoothness;
            float _ParalaxOffset;
            float _IceParallaxSteps;
            float _IceDepth;
            float _ParallaxFalloff;
            float _IceParallaxNoiseScale;
            float _IceParallaxNoiseMin;
            float _IceParallaxNoiseMax;
            float _CoverMaskPower;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Amount;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float _CoverHardness;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
            float _CoverMetallic;
            float _CoverAORemapMin;
            float _CoverAORemapMax;
            float _CoverSmoothnessRemapMin;
            float _CoverSmoothnessRemapMax;
            float4 _DetailTilingOffset;
            float _DetailAlbedoScale;
            float _DetailNormalScale;
            float _DetailSmoothnessScale;
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_IceNoiseNormal); SAMPLER(sampler_IceNoiseNormal); float4 _IceNoiseNormal_TexelSize;
            TEXTURE2D(_ParalaxMap); SAMPLER(sampler_ParalaxMap); float4 _ParalaxMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_CD9C50D2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A42D1072_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }
            
            void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
            {
                Out = UV * Tiling + Offset;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
            {
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
            {
                float _Property_7E8A3125_Out_0 = Boolean_7ABB9909;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_C4659339_Out_0 = Vector4_2EBA7A3B;
                float _Split_73D91F75_R_1 = _Property_C4659339_Out_0[0];
                float _Split_73D91F75_G_2 = _Property_C4659339_Out_0[1];
                float _Split_73D91F75_B_3 = _Property_C4659339_Out_0[2];
                float _Split_73D91F75_A_4 = _Property_C4659339_Out_0[3];
                float _Divide_26B6AE80_Out_2;
                Unity_Divide_float(1, _Split_73D91F75_R_1, _Divide_26B6AE80_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_26B6AE80_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_6DD20118_Out_0 = float2(_Split_73D91F75_R_1, _Split_73D91F75_G_2);
                float2 _Vector2_AF5F407D_Out_0 = float2(_Split_73D91F75_B_3, _Split_73D91F75_A_4);
                float2 _TilingAndOffset_1DC08BD9_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6DD20118_Out_0, _Vector2_AF5F407D_Out_0, _TilingAndOffset_1DC08BD9_Out_3);
                float2 _Branch_4FEBA43B_Out_3;
                Unity_Branch_float2(_Property_7E8A3125_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_1DC08BD9_Out_3, _Branch_4FEBA43B_Out_3);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_4FEBA43B_Out_3);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                XZ_2 = _SampleTexture2D_AF934D9A_RGBA_0;
            }
            
            struct Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151
            {
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151(float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151 IN, out float4 XZ_2)
            {
                float _Property_7E8A3125_Out_0 = Boolean_7ABB9909;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_C4659339_Out_0 = Vector4_2EBA7A3B;
                float _Split_73D91F75_R_1 = _Property_C4659339_Out_0[0];
                float _Split_73D91F75_G_2 = _Property_C4659339_Out_0[1];
                float _Split_73D91F75_B_3 = _Property_C4659339_Out_0[2];
                float _Split_73D91F75_A_4 = _Property_C4659339_Out_0[3];
                float _Divide_26B6AE80_Out_2;
                Unity_Divide_float(1, _Split_73D91F75_R_1, _Divide_26B6AE80_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_26B6AE80_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_6DD20118_Out_0 = float2(_Split_73D91F75_R_1, _Split_73D91F75_G_2);
                float2 _Vector2_AF5F407D_Out_0 = float2(_Split_73D91F75_B_3, _Split_73D91F75_A_4);
                float2 _TilingAndOffset_1DC08BD9_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6DD20118_Out_0, _Vector2_AF5F407D_Out_0, _TilingAndOffset_1DC08BD9_Out_3);
                float2 _Branch_4FEBA43B_Out_3;
                Unity_Branch_float2(_Property_7E8A3125_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_1DC08BD9_Out_3, _Branch_4FEBA43B_Out_3);
                XZ_2 = (float4(_Branch_4FEBA43B_Out_3, 0.0, 1.0));
            }
            
            
            inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
            {
                return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
            }
            
            inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
            {
                return (1.0-t)*a + (t*b);
            }
            
            
            inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
            {
                float2 i = floor(uv);
                float2 f = frac(uv);
                f = f * f * (3.0 - 2.0 * f);
            
                uv = abs(frac(uv) - 0.5);
                float2 c0 = i + float2(0.0, 0.0);
                float2 c1 = i + float2(1.0, 0.0);
                float2 c2 = i + float2(0.0, 1.0);
                float2 c3 = i + float2(1.0, 1.0);
                float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                float r3 = Unity_SimpleNoise_RandomValue_float(c3);
            
                float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                return t;
            }
            void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
            {
                float t = 0.0;
            
                float freq = pow(2.0, float(0));
                float amp = pow(0.5, float(3-0));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                freq = pow(2.0, float(1));
                amp = pow(0.5, float(3-1));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                freq = pow(2.0, float(2));
                amp = pow(0.5, float(3-2));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                Out = t;
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            // 1ab7832f84992b571d2fa80a089d3a8e
            #include "Assets/NatureManufacture Assets/Object Shaders/NMParallaxLayers.hlsl"
            
            void Unity_Blend_Lighten_float4(float4 Base, float4 Blend, out float4 Out, float Opacity)
            {
                Out = max(Blend, Base);
                Out = lerp(Base, Out, Opacity);
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Contrast_float(float3 In, float Contrast, out float3 Out)
            {
                float midpoint = pow(0.5, 2.2);
                Out =  (In - midpoint) * Contrast + midpoint;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_SquareRoot_float4(float4 In, out float4 Out)
            {
                Out = sqrt(In);
            }
            
            void Unity_Sign_float(float In, out float Out)
            {
                Out = sign(In);
            }
            
            void Unity_Ceiling_float(float In, out float Out)
            {
                Out = ceil(In);
            }
            
            struct Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2
            {
            };
            
            void SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(float4 Color_9AA111D3, float Vector1_FBE622A2, float Vector1_8C15C351, Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 IN, out float3 OutVector4_1)
            {
                float4 _Property_90A62E4E_Out_0 = Color_9AA111D3;
                float4 _SquareRoot_51430F5B_Out_1;
                Unity_SquareRoot_float4(_Property_90A62E4E_Out_0, _SquareRoot_51430F5B_Out_1);
                float _Property_4C27E21E_Out_0 = Vector1_FBE622A2;
                float _Sign_2EB7E10D_Out_1;
                Unity_Sign_float(_Property_4C27E21E_Out_0, _Sign_2EB7E10D_Out_1);
                float _Add_29F1B1C0_Out_2;
                Unity_Add_float(_Sign_2EB7E10D_Out_1, 1, _Add_29F1B1C0_Out_2);
                float _Multiply_E5F6C023_Out_2;
                Unity_Multiply_float(_Add_29F1B1C0_Out_2, 0.5, _Multiply_E5F6C023_Out_2);
                float _Ceiling_85D24F96_Out_1;
                Unity_Ceiling_float(_Multiply_E5F6C023_Out_2, _Ceiling_85D24F96_Out_1);
                float _Property_33C740F_Out_0 = Vector1_8C15C351;
                float _Multiply_ED89DC5B_Out_2;
                Unity_Multiply_float(_Property_33C740F_Out_0, _Property_33C740F_Out_0, _Multiply_ED89DC5B_Out_2);
                float4 _Lerp_CA077B77_Out_3;
                Unity_Lerp_float4(_SquareRoot_51430F5B_Out_1, (_Ceiling_85D24F96_Out_1.xxxx), (_Multiply_ED89DC5B_Out_2.xxxx), _Lerp_CA077B77_Out_3);
                float4 _Multiply_9305D041_Out_2;
                Unity_Multiply_float(_Lerp_CA077B77_Out_3, _Lerp_CA077B77_Out_3, _Multiply_9305D041_Out_2);
                OutVector4_1 = (_Multiply_9305D041_Out_2.xyz);
            }
            
            void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_DotProduct_float2(float2 A, float2 B, out float Out)
            {
                Out = dot(A, B);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_SquareRoot_float(float In, out float Out)
            {
                Out = sqrt(In);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Normalize_float3(float3 In, out float3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
            {
                float _Property_EECC5191_Out_0 = Boolean_9FF42DF6;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_3C0E791E_Out_0 = Vector4_82674548;
                float _Split_BDB607D3_R_1 = _Property_3C0E791E_Out_0[0];
                float _Split_BDB607D3_G_2 = _Property_3C0E791E_Out_0[1];
                float _Split_BDB607D3_B_3 = _Property_3C0E791E_Out_0[2];
                float _Split_BDB607D3_A_4 = _Property_3C0E791E_Out_0[3];
                float _Divide_99B56138_Out_2;
                Unity_Divide_float(1, _Split_BDB607D3_R_1, _Divide_99B56138_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_99B56138_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_870D34BF_Out_0 = float2(_Split_BDB607D3_R_1, _Split_BDB607D3_G_2);
                float2 _Vector2_9D160F08_Out_0 = float2(_Split_BDB607D3_B_3, _Split_BDB607D3_A_4);
                float2 _TilingAndOffset_C775B36F_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_870D34BF_Out_0, _Vector2_9D160F08_Out_0, _TilingAndOffset_C775B36F_Out_3);
                float2 _Branch_F57F5E8_Out_3;
                Unity_Branch_float2(_Property_EECC5191_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_C775B36F_Out_3, _Branch_F57F5E8_Out_3);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_F57F5E8_Out_3);
                _SampleTexture2D_AF934D9A_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AF934D9A_RGBA_0);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float2 _Vector2_699A5DA1_Out_0 = float2(_SampleTexture2D_AF934D9A_R_4, _SampleTexture2D_AF934D9A_G_5);
                float3 _Sign_937BD7C4_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_937BD7C4_Out_1);
                float _Split_A88C5CBA_R_1 = _Sign_937BD7C4_Out_1[0];
                float _Split_A88C5CBA_G_2 = _Sign_937BD7C4_Out_1[1];
                float _Split_A88C5CBA_B_3 = _Sign_937BD7C4_Out_1[2];
                float _Split_A88C5CBA_A_4 = 0;
                float2 _Vector2_DC7A07A_Out_0 = float2(_Split_A88C5CBA_G_2, 1);
                float2 _Multiply_5A3A785C_Out_2;
                Unity_Multiply_float(_Vector2_699A5DA1_Out_0, _Vector2_DC7A07A_Out_0, _Multiply_5A3A785C_Out_2);
                float _Split_CE0AB7C6_R_1 = IN.WorldSpaceNormal[0];
                float _Split_CE0AB7C6_G_2 = IN.WorldSpaceNormal[1];
                float _Split_CE0AB7C6_B_3 = IN.WorldSpaceNormal[2];
                float _Split_CE0AB7C6_A_4 = 0;
                float2 _Vector2_D40FA1D3_Out_0 = float2(_Split_CE0AB7C6_R_1, _Split_CE0AB7C6_B_3);
                float2 _Add_E4BBD98D_Out_2;
                Unity_Add_float2(_Multiply_5A3A785C_Out_2, _Vector2_D40FA1D3_Out_0, _Add_E4BBD98D_Out_2);
                float _Split_1D7F6EE9_R_1 = _Add_E4BBD98D_Out_2[0];
                float _Split_1D7F6EE9_G_2 = _Add_E4BBD98D_Out_2[1];
                float _Split_1D7F6EE9_B_3 = 0;
                float _Split_1D7F6EE9_A_4 = 0;
                float _Multiply_D1C95945_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_B_6, _Split_CE0AB7C6_G_2, _Multiply_D1C95945_Out_2);
                float3 _Vector3_CB17D4AB_Out_0 = float3(_Split_1D7F6EE9_R_1, _Multiply_D1C95945_Out_2, _Split_1D7F6EE9_G_2);
                float3x3 Transform_D163BAD_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_D163BAD_Out_1 = TransformWorldToTangent(_Vector3_CB17D4AB_Out_0.xyz, Transform_D163BAD_tangentTransform_World);
                float3 _Normalize_49BB8375_Out_1;
                Unity_Normalize_float3(_Transform_D163BAD_Out_1, _Normalize_49BB8375_Out_1);
                float3 _Branch_CB8BD7A6_Out_3;
                Unity_Branch_float3(_Property_EECC5191_Out_0, _Normalize_49BB8375_Out_1, (_SampleTexture2D_AF934D9A_RGBA_0.xyz), _Branch_CB8BD7A6_Out_3);
                XZ_2 = (float4(_Branch_CB8BD7A6_Out_3, 1.0));
            }
            
            void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
            {
                Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceBiTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceViewDirection;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 AbsoluteWorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3E4B16C8_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F2A4C04A_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_605BEBB1;
                _PlanarNM_605BEBB1.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_605BEBB1.uv0 = IN.uv0;
                float4 _PlanarNM_605BEBB1_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNM_605BEBB1, _PlanarNM_605BEBB1_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F69A7540_Out_0 = _IceParallaxSteps;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151 _PlanarNMparallax_19C7D294;
                _PlanarNMparallax_19C7D294.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMparallax_19C7D294.uv0 = IN.uv0;
                float4 _PlanarNMparallax_19C7D294_XZ_2;
                SG_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151(_Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMparallax_19C7D294, _PlanarNMparallax_19C7D294_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_584447FF_Out_0 = _ParalaxOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_25AD48E5_Out_0 = _IceParallaxNoiseMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_98575B71_Out_0 = _IceParallaxNoiseMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_16DB2C3A_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_16DB2C3A_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_16DB2C3A_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_16DB2C3A_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_BE79C1A8_Out_0 = float2(_Split_16DB2C3A_R_1, _Split_16DB2C3A_B_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_543B17EA_Out_0 = _IceParallaxNoiseScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SimpleNoise_CCF200D9_Out_2;
                Unity_SimpleNoise_float(_Vector2_BE79C1A8_Out_0, _Property_543B17EA_Out_0, _SimpleNoise_CCF200D9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_5C49F379_Out_3;
                Unity_Lerp_float(_Property_25AD48E5_Out_0, _Property_98575B71_Out_0, _SimpleNoise_CCF200D9_Out_2, _Lerp_5C49F379_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_A34AA065_Out_3;
                Unity_Lerp_float(_Property_584447FF_Out_0, 0, _Lerp_5C49F379_Out_3, _Lerp_A34AA065_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_36F6A6D0_Out_0 = _IceDepth;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3x3 Transform_D9CFEC5_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_D9CFEC5_Out_1 = TransformWorldToTangent(IN.WorldSpaceViewDirection.xyz, Transform_D9CFEC5_tangentTransform_World);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_39D230AF_Out_0 = _ParallaxFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_ED48CB71_Out_3;
                Unity_Lerp_float(_Property_39D230AF_Out_0, 0, _Lerp_5C49F379_Out_3, _Lerp_ED48CB71_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _CustomFunction_92A39E95_Out_2;
                ParallaxLayers_float(_Property_F69A7540_Out_0, (_PlanarNMparallax_19C7D294_XZ_2.xy), _Lerp_A34AA065_Out_3, _Property_36F6A6D0_Out_0, _Transform_D9CFEC5_Out_1, IN.WorldSpaceViewDirection, _Lerp_ED48CB71_Out_3, _Property_F2A4C04A_Out_0, _CustomFunction_92A39E95_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Blend_F08AFA54_Out_2;
                Unity_Blend_Lighten_float4(_PlanarNM_605BEBB1_XZ_2, _CustomFunction_92A39E95_Out_2, _Blend_F08AFA54_Out_2, _Property_39D230AF_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_C4180B07_Out_0 = _DeepColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2896096E_Out_0 = _IceNoiseScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SimpleNoise_608BDE5D_Out_2;
                Unity_SimpleNoise_float(_Vector2_BE79C1A8_Out_0, _Property_2896096E_Out_0, _SimpleNoise_608BDE5D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_39A6A18_Out_1;
                Unity_Absolute_float(_SimpleNoise_608BDE5D_Out_2, _Absolute_39A6A18_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F52DBFE9_Out_0 = _IceNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Power_3A1C69E3_Out_2;
                Unity_Power_float(_Absolute_39A6A18_Out_1, _Property_F52DBFE9_Out_0, _Power_3A1C69E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C2BBB8DB_Out_0 = _IceNoiseContrast;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Contrast_D1EA0699_Out_2;
                Unity_Contrast_float((_Power_3A1C69E3_Out_2.xxx), _Property_C2BBB8DB_Out_0, _Contrast_D1EA0699_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9D04AA67_R_1 = _Contrast_D1EA0699_Out_2[0];
                float _Split_9D04AA67_G_2 = _Contrast_D1EA0699_Out_2[1];
                float _Split_9D04AA67_B_3 = _Contrast_D1EA0699_Out_2[2];
                float _Split_9D04AA67_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_7C8D44C6_Out_3;
                Unity_Clamp_float(_Split_9D04AA67_R_1, 0, 1, _Clamp_7C8D44C6_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Lerp_10B48734_Out_3;
                Unity_Lerp_float4(_Blend_F08AFA54_Out_2, _Property_C4180B07_Out_0, (_Clamp_7C8D44C6_Out_3.xxxx), _Lerp_10B48734_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3D23ECB5_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_3B5A4F3A_Out_2;
                Unity_Multiply_float(_Lerp_10B48734_Out_3, _Property_3D23ECB5_Out_0, _Multiply_3B5A4F3A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_FC905A02_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_66FEB2D6_R_1 = _Property_FC905A02_Out_0[0];
                float _Split_66FEB2D6_G_2 = _Property_FC905A02_Out_0[1];
                float _Split_66FEB2D6_B_3 = _Property_FC905A02_Out_0[2];
                float _Split_66FEB2D6_A_4 = _Property_FC905A02_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_2C65450F_Out_0 = float2(_Split_66FEB2D6_R_1, _Split_66FEB2D6_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_20821B1B_Out_0 = float2(_Split_66FEB2D6_B_3, _Split_66FEB2D6_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_AFDF49A5_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_2C65450F_Out_0, _Vector2_20821B1B_Out_0, _TilingAndOffset_AFDF49A5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_CD9C50D2_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_AFDF49A5_Out_3);
                float _SampleTexture2D_CD9C50D2_R_4 = _SampleTexture2D_CD9C50D2_RGBA_0.r;
                float _SampleTexture2D_CD9C50D2_G_5 = _SampleTexture2D_CD9C50D2_RGBA_0.g;
                float _SampleTexture2D_CD9C50D2_B_6 = _SampleTexture2D_CD9C50D2_RGBA_0.b;
                float _SampleTexture2D_CD9C50D2_A_7 = _SampleTexture2D_CD9C50D2_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_6CEB2199_Out_2;
                Unity_Multiply_float(_SampleTexture2D_CD9C50D2_R_4, 2, _Multiply_6CEB2199_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_81546154_Out_2;
                Unity_Add_float(_Multiply_6CEB2199_Out_2, -1, _Add_81546154_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2152BC92_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_4FF44BF6_Out_2;
                Unity_Multiply_float(_Add_81546154_Out_2, _Property_2152BC92_Out_0, _Multiply_4FF44BF6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_44A6B3E6_Out_1;
                Unity_Saturate_float(_Multiply_4FF44BF6_Out_2, _Saturate_44A6B3E6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_252B9168_Out_1;
                Unity_Absolute_float(_Saturate_44A6B3E6_Out_1, _Absolute_252B9168_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_DC11EFE2;
                float3 _BlendOverlayBaseColor_DC11EFE2_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_3B5A4F3A_Out_2, _Add_81546154_Out_2, _Absolute_252B9168_Out_1, _BlendOverlayBaseColor_DC11EFE2, _BlendOverlayBaseColor_DC11EFE2_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_E0773BA3_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6388FCB5_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_37241974;
                _PlanarNM_37241974.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_37241974.uv0 = IN.uv0;
                float4 _PlanarNM_37241974_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNM_37241974, _PlanarNM_37241974_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_AF2EEB1D_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_64C7F396_Out_2;
                Unity_Multiply_float(_PlanarNM_37241974_XZ_2, _Property_AF2EEB1D_Out_0, _Multiply_64C7F396_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_23C9E59F_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_A42D1072_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_23C9E59F_Out_0.xy));
                float _SampleTexture2D_A42D1072_R_4 = _SampleTexture2D_A42D1072_RGBA_0.r;
                float _SampleTexture2D_A42D1072_G_5 = _SampleTexture2D_A42D1072_RGBA_0.g;
                float _SampleTexture2D_A42D1072_B_6 = _SampleTexture2D_A42D1072_RGBA_0.b;
                float _SampleTexture2D_A42D1072_A_7 = _SampleTexture2D_A42D1072_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_23BACCE9_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_E1E6CA0C_Out_2;
                Unity_Multiply_float(_SampleTexture2D_A42D1072_A_7, _Property_23BACCE9_Out_0, _Multiply_E1E6CA0C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_E47EFF9E_Out_3;
                Unity_Clamp_float(_Multiply_E1E6CA0C_Out_2, 0, 1, _Clamp_E47EFF9E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Clamp_93A41266_Out_3;
                Unity_Clamp_float4(IN.VertexColor, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_93A41266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A30F99_R_1 = _Clamp_93A41266_Out_3[0];
                float _Split_A30F99_G_2 = _Clamp_93A41266_Out_3[1];
                float _Split_A30F99_B_3 = _Clamp_93A41266_Out_3[2];
                float _Split_A30F99_A_4 = _Clamp_93A41266_Out_3[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_D25079B9_Out_0 = float2(_SampleTexture2D_CD9C50D2_A_7, _SampleTexture2D_CD9C50D2_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_A6D263CC_Out_2;
                Unity_Multiply_float(_Vector2_D25079B9_Out_0, float2(2, 2), _Multiply_A6D263CC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_A94F92F2_Out_2;
                Unity_Add_float2(_Multiply_A6D263CC_Out_2, float2(-1, -1), _Add_A94F92F2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_5A04D61A_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_E3BBD5A0_Out_2;
                Unity_Multiply_float(_Add_A94F92F2_Out_2, (_Property_5A04D61A_Out_0.xx), _Multiply_E3BBD5A0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_3BC0AA96_R_1 = _Multiply_E3BBD5A0_Out_2[0];
                float _Split_3BC0AA96_G_2 = _Multiply_E3BBD5A0_Out_2[1];
                float _Split_3BC0AA96_B_3 = 0;
                float _Split_3BC0AA96_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _DotProduct_9FB0B73C_Out_2;
                Unity_DotProduct_float2(_Multiply_E3BBD5A0_Out_2, _Multiply_E3BBD5A0_Out_2, _DotProduct_9FB0B73C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_3C8C4A9B_Out_1;
                Unity_Saturate_float(_DotProduct_9FB0B73C_Out_2, _Saturate_3C8C4A9B_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_E0A2EC16_Out_1;
                Unity_OneMinus_float(_Saturate_3C8C4A9B_Out_1, _OneMinus_E0A2EC16_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _SquareRoot_7D6FC55F_Out_1;
                Unity_SquareRoot_float(_OneMinus_E0A2EC16_Out_1, _SquareRoot_7D6FC55F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Vector3_408E9F99_Out_0 = float3(_Split_3BC0AA96_R_1, _Split_3BC0AA96_G_2, _SquareRoot_7D6FC55F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_F0D9C40B;
                _PlanarNMn_F0D9C40B.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_F0D9C40B.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_F0D9C40B.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_F0D9C40B.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_F0D9C40B.uv0 = IN.uv0;
                float4 _PlanarNMn_F0D9C40B_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMn_F0D9C40B, _PlanarNMn_F0D9C40B_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1CABD952_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_EDF1EB8B_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_F0D9C40B_XZ_2.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_B7F72910;
                _PlanarNMn_B7F72910.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_B7F72910.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_B7F72910.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_B7F72910.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_B7F72910.uv0 = IN.uv0;
                float4 _PlanarNMn_B7F72910_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_IceNoiseNormal, sampler_IceNoiseNormal), _IceNoiseNormal_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMn_B7F72910, _PlanarNMn_B7F72910_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_3E79A67D_Out_0 = _NoiseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_DC5D8477_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_B7F72910_XZ_2.xyz), _Property_3E79A67D_Out_0, _NormalStrength_DC5D8477_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_13B2C2D_Out_3;
                Unity_Lerp_float3(_NormalStrength_EDF1EB8B_Out_2, _NormalStrength_DC5D8477_Out_2, (_Clamp_7C8D44C6_Out_3.xxx), _Lerp_13B2C2D_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalBlend_24C86B99_Out_2;
                Unity_NormalBlend_float(_Vector3_408E9F99_Out_0, _Lerp_13B2C2D_Out_3, _NormalBlend_24C86B99_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_82A01385;
                _PlanarNMn_82A01385.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_82A01385.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_82A01385.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_82A01385.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_82A01385.uv0 = IN.uv0;
                float4 _PlanarNMn_82A01385_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNMn_82A01385, _PlanarNMn_82A01385_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_2BC6CE93_Out_0 = _CoverNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_EE9C3A89_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_82A01385_XZ_2.xyz), _Property_2BC6CE93_Out_0, _NormalStrength_EE9C3A89_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_285FA03B_R_1 = IN.WorldSpaceNormal[0];
                float _Split_285FA03B_G_2 = IN.WorldSpaceNormal[1];
                float _Split_285FA03B_B_3 = IN.WorldSpaceNormal[2];
                float _Split_285FA03B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_A78EDC1C_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9F8A8080_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_F2912DD5_Out_2;
                Unity_Subtract_float(4, _Property_9F8A8080_Out_0, _Subtract_F2912DD5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_D14A542B_Out_2;
                Unity_Divide_float(_Property_A78EDC1C_Out_0, _Subtract_F2912DD5_Out_2, _Divide_D14A542B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_CBDEAEC6_Out_1;
                Unity_Absolute_float(_Divide_D14A542B_Out_2, _Absolute_CBDEAEC6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_468546B2_Out_2;
                Unity_Power_float(_Absolute_CBDEAEC6_Out_1, _Subtract_F2912DD5_Out_2, _Power_468546B2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_505BD7CB_Out_3;
                Unity_Clamp_float(_Power_468546B2_Out_2, 0, 2, _Clamp_505BD7CB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_C557E9AF_Out_2;
                Unity_Multiply_float(_Split_285FA03B_G_2, _Clamp_505BD7CB_Out_3, _Multiply_C557E9AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_AAEFC124_Out_1;
                Unity_Saturate_float(_Multiply_C557E9AF_Out_2, _Saturate_AAEFC124_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_FE0E6938_Out_3;
                Unity_Clamp_float(_Split_285FA03B_G_2, 0, 0.9999, _Clamp_FE0E6938_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9FAF9E79_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_C024499C_Out_2;
                Unity_Divide_float(_Property_9FAF9E79_Out_0, 45, _Divide_C024499C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_819C6AF2_Out_1;
                Unity_OneMinus_float(_Divide_C024499C_Out_2, _OneMinus_819C6AF2_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_E0C6446E_Out_2;
                Unity_Subtract_float(_Clamp_FE0E6938_Out_3, _OneMinus_819C6AF2_Out_1, _Subtract_E0C6446E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_9DD83AC8_Out_3;
                Unity_Clamp_float(_Subtract_E0C6446E_Out_2, 0, 2, _Clamp_9DD83AC8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_FA29401D_Out_2;
                Unity_Divide_float(1, _Divide_C024499C_Out_2, _Divide_FA29401D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_4D0D7B0_Out_2;
                Unity_Multiply_float(_Clamp_9DD83AC8_Out_3, _Divide_FA29401D_Out_2, _Multiply_4D0D7B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_128CA3C3_Out_1;
                Unity_Absolute_float(_Multiply_4D0D7B0_Out_2, _Absolute_128CA3C3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_CFA12E7D_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_5ED343D8_Out_2;
                Unity_Power_float(_Absolute_128CA3C3_Out_1, _Property_CFA12E7D_Out_0, _Power_5ED343D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_3BC73AD4_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_5124E5F6_Out_1;
                Unity_OneMinus_float(_Property_3BC73AD4_Out_0, _OneMinus_5124E5F6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_2735CEFA_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_2735CEFA_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_2735CEFA_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_2735CEFA_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_ED205FBF_Out_2;
                Unity_Add_float(_OneMinus_5124E5F6_Out_1, _Split_2735CEFA_G_2, _Add_ED205FBF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_752AF7A2_Out_2;
                Unity_Add_float(_Add_ED205FBF_Out_2, 1, _Add_752AF7A2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_E090F386_Out_3;
                Unity_Clamp_float(_Add_752AF7A2_Out_2, 0, 1, _Clamp_E090F386_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_73B1AD10_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_331D8064_Out_2;
                Unity_Add_float(_Add_ED205FBF_Out_2, _Property_73B1AD10_Out_0, _Add_331D8064_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_CB58FE2E_Out_2;
                Unity_Divide_float(_Add_331D8064_Out_2, _Add_ED205FBF_Out_2, _Divide_CB58FE2E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1ABEFCE6_Out_1;
                Unity_OneMinus_float(_Divide_CB58FE2E_Out_2, _OneMinus_1ABEFCE6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_8F137BF7_Out_2;
                Unity_Add_float(_OneMinus_1ABEFCE6_Out_1, -0.5, _Add_8F137BF7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_35395974_Out_3;
                Unity_Clamp_float(_Add_8F137BF7_Out_2, 0, 1, _Clamp_35395974_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DC8DD517_Out_2;
                Unity_Add_float(_Clamp_E090F386_Out_3, _Clamp_35395974_Out_3, _Add_DC8DD517_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_978A71EF_Out_3;
                Unity_Clamp_float(_Add_DC8DD517_Out_2, 0, 1, _Clamp_978A71EF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_85C9E9EE_Out_2;
                Unity_Multiply_float(_Power_5ED343D8_Out_2, _Clamp_978A71EF_Out_3, _Multiply_85C9E9EE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D14C5FA5_Out_2;
                Unity_Multiply_float(_Saturate_AAEFC124_Out_1, _Multiply_85C9E9EE_Out_2, _Multiply_D14C5FA5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_B3376A42_Out_3;
                Unity_Lerp_float3(_NormalBlend_24C86B99_Out_2, _NormalStrength_EE9C3A89_Out_2, (_Multiply_D14C5FA5_Out_2.xxx), _Lerp_B3376A42_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_D1A2C0A3_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_D1A2C0A3_Out_1 = mul(Transform_D1A2C0A3_transposeTangent, _Lerp_B3376A42_Out_3.xyz).xyz;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_B0D440A_R_1 = _Transform_D1A2C0A3_Out_1[0];
                float _Split_B0D440A_G_2 = _Transform_D1A2C0A3_Out_1[1];
                float _Split_B0D440A_B_3 = _Transform_D1A2C0A3_Out_1[2];
                float _Split_B0D440A_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_730C1F53_Out_2;
                Unity_Multiply_float(_Split_B0D440A_G_2, _Clamp_505BD7CB_Out_3, _Multiply_730C1F53_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_B2B3901D_Out_2;
                Unity_Multiply_float(_Clamp_505BD7CB_Out_3, _Property_CFA12E7D_Out_0, _Multiply_B2B3901D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_A7C78B4E_Out_2;
                Unity_Multiply_float(_Multiply_B2B3901D_Out_2, _Multiply_85C9E9EE_Out_2, _Multiply_A7C78B4E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_A9771D5F_Out_2;
                Unity_Multiply_float(_Multiply_730C1F53_Out_2, _Multiply_A7C78B4E_Out_2, _Multiply_A9771D5F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_1C1C26F9;
                _PlanarNM_1C1C26F9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_1C1C26F9.uv0 = IN.uv0;
                float4 _PlanarNM_1C1C26F9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNM_1C1C26F9, _PlanarNM_1C1C26F9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_C5FA0079_R_1 = _PlanarNM_1C1C26F9_XZ_2[0];
                float _Split_C5FA0079_G_2 = _PlanarNM_1C1C26F9_XZ_2[1];
                float _Split_C5FA0079_B_3 = _PlanarNM_1C1C26F9_XZ_2[2];
                float _Split_C5FA0079_A_4 = _PlanarNM_1C1C26F9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_79C0622E_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_F9B7976A_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_2075ED8D_Out_0 = float2(_Property_79C0622E_Out_0, _Property_F9B7976A_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_39A9ADEC_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_DFDDD509_Out_2;
                Unity_Add_float2(_Vector2_2075ED8D_Out_0, (_Property_39A9ADEC_Out_0.xx), _Add_DFDDD509_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_64922366_Out_3;
                Unity_Remap_float(_Split_C5FA0079_B_3, float2 (0, 1), _Add_DFDDD509_Out_2, _Remap_64922366_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5DF35CED_Out_2;
                Unity_Multiply_float(_Multiply_A9771D5F_Out_2, _Remap_64922366_Out_3, _Multiply_5DF35CED_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_46650FF2_Out_2;
                Unity_Multiply_float(_Split_A30F99_G_2, _Multiply_5DF35CED_Out_2, _Multiply_46650FF2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_A6088ECC_Out_1;
                Unity_Saturate_float(_Multiply_46650FF2_Out_2, _Saturate_A6088ECC_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_FDFD4BAD_Out_2;
                Unity_Multiply_float(_Clamp_E47EFF9E_Out_3, _Saturate_A6088ECC_Out_1, _Multiply_FDFD4BAD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_6DA1DCFE_Out_3;
                Unity_Clamp_float(_Multiply_FDFD4BAD_Out_2, 0, 1, _Clamp_6DA1DCFE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_11641B3F_Out_0 = _Clamp_6DA1DCFE_Out_3;
                #else
                float _UseDynamicCoverTStaticMaskF_11641B3F_Out_0 = _Clamp_E47EFF9E_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_8BDA8462_Out_3;
                Unity_Clamp_float(_UseDynamicCoverTStaticMaskF_11641B3F_Out_0, 0, 1, _Clamp_8BDA8462_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_6387F1BD_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_DC11EFE2_OutVector4_1, (_Multiply_64C7F396_Out_2.xyz), (_Clamp_8BDA8462_Out_3.xxx), _Lerp_6387F1BD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_FCA5654_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_8F3F0743_Out_2;
                Unity_Multiply_float((_Property_FCA5654_Out_0.xyz), _Lerp_6387F1BD_Out_3, _Multiply_8F3F0743_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_3E465E6D_Out_1;
                Unity_OneMinus_float(_Split_A30F99_R_1, _OneMinus_3E465E6D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_D3906CE2_Out_3;
                Unity_Lerp_float3(_Lerp_6387F1BD_Out_3, _Multiply_8F3F0743_Out_2, (_OneMinus_3E465E6D_Out_1.xxx), _Lerp_D3906CE2_Out_3);
                #endif
                surface.Albedo = _Lerp_D3906CE2_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Alpha = 1;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0 : TEXCOORD0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv1 : TEXCOORD1;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv2 : TEXCOORD2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_Position;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 viewDirectionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 bitangentWS;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
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
                float3 interp05 : TEXCOORD5;
                float3 interp06 : TEXCOORD6;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.color;
                output.interp05.xyz = input.viewDirectionWS;
                output.interp06.xyz = input.bitangentWS;
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
                Varyings output;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.color = input.interp04.xyzw;
                output.viewDirectionWS = input.interp05.xyz;
                output.bitangentWS = input.interp06.xyz;
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
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            input.normalWS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceTangent =           input.tangentWS.xyz;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceBiTangent =         input.bitangentWS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
            #endif
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
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
            Blend One Zero, One Zero
            Cull Back
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
            #pragma shader_feature_local _ _USEDYNAMICCOVERTSTATICMASKF_ON
            
            #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _AlphaClip 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_BITANGENT_WS
        #endif
        
        
        
        
            #define SHADERPASS_2D
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            float4 _DeepColor;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float _IceNoiseScale;
            float _IceNoiseContrast;
            float _IceNoisePower;
            float _BaseNormalScale;
            float _NoiseNormalScale;
            float _BaseMetallic;
            float _BaseAO;
            float _IceSmoothness;
            float _IceCrackSmoothness;
            float _IceNoiseSmoothness;
            float _ParalaxOffset;
            float _IceParallaxSteps;
            float _IceDepth;
            float _ParallaxFalloff;
            float _IceParallaxNoiseScale;
            float _IceParallaxNoiseMin;
            float _IceParallaxNoiseMax;
            float _CoverMaskPower;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Amount;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float _CoverHardness;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
            float _CoverMetallic;
            float _CoverAORemapMin;
            float _CoverAORemapMax;
            float _CoverSmoothnessRemapMin;
            float _CoverSmoothnessRemapMax;
            float4 _DetailTilingOffset;
            float _DetailAlbedoScale;
            float _DetailNormalScale;
            float _DetailSmoothnessScale;
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_IceNoiseNormal); SAMPLER(sampler_IceNoiseNormal); float4 _IceNoiseNormal_TexelSize;
            TEXTURE2D(_ParalaxMap); SAMPLER(sampler_ParalaxMap); float4 _ParalaxMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_CD9C50D2_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A42D1072_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
            {
                RGBA = float4(R, G, B, A);
                RGB = float3(R, G, B);
                RG = float2(R, G);
            }
            
            void Unity_Divide_float(float A, float B, out float Out)
            {
                Out = A / B;
            }
            
            void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }
            
            void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
            {
                Out = UV * Tiling + Offset;
            }
            
            void Unity_Branch_float2(float Predicate, float2 True, float2 False, out float2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            struct Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6
            {
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 IN, out float4 XZ_2)
            {
                float _Property_7E8A3125_Out_0 = Boolean_7ABB9909;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_C4659339_Out_0 = Vector4_2EBA7A3B;
                float _Split_73D91F75_R_1 = _Property_C4659339_Out_0[0];
                float _Split_73D91F75_G_2 = _Property_C4659339_Out_0[1];
                float _Split_73D91F75_B_3 = _Property_C4659339_Out_0[2];
                float _Split_73D91F75_A_4 = _Property_C4659339_Out_0[3];
                float _Divide_26B6AE80_Out_2;
                Unity_Divide_float(1, _Split_73D91F75_R_1, _Divide_26B6AE80_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_26B6AE80_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_6DD20118_Out_0 = float2(_Split_73D91F75_R_1, _Split_73D91F75_G_2);
                float2 _Vector2_AF5F407D_Out_0 = float2(_Split_73D91F75_B_3, _Split_73D91F75_A_4);
                float2 _TilingAndOffset_1DC08BD9_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6DD20118_Out_0, _Vector2_AF5F407D_Out_0, _TilingAndOffset_1DC08BD9_Out_3);
                float2 _Branch_4FEBA43B_Out_3;
                Unity_Branch_float2(_Property_7E8A3125_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_1DC08BD9_Out_3, _Branch_4FEBA43B_Out_3);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_4FEBA43B_Out_3);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                XZ_2 = _SampleTexture2D_AF934D9A_RGBA_0;
            }
            
            struct Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151
            {
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151(float4 Vector4_2EBA7A3B, float Boolean_7ABB9909, Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151 IN, out float4 XZ_2)
            {
                float _Property_7E8A3125_Out_0 = Boolean_7ABB9909;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_C4659339_Out_0 = Vector4_2EBA7A3B;
                float _Split_73D91F75_R_1 = _Property_C4659339_Out_0[0];
                float _Split_73D91F75_G_2 = _Property_C4659339_Out_0[1];
                float _Split_73D91F75_B_3 = _Property_C4659339_Out_0[2];
                float _Split_73D91F75_A_4 = _Property_C4659339_Out_0[3];
                float _Divide_26B6AE80_Out_2;
                Unity_Divide_float(1, _Split_73D91F75_R_1, _Divide_26B6AE80_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_26B6AE80_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_6DD20118_Out_0 = float2(_Split_73D91F75_R_1, _Split_73D91F75_G_2);
                float2 _Vector2_AF5F407D_Out_0 = float2(_Split_73D91F75_B_3, _Split_73D91F75_A_4);
                float2 _TilingAndOffset_1DC08BD9_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_6DD20118_Out_0, _Vector2_AF5F407D_Out_0, _TilingAndOffset_1DC08BD9_Out_3);
                float2 _Branch_4FEBA43B_Out_3;
                Unity_Branch_float2(_Property_7E8A3125_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_1DC08BD9_Out_3, _Branch_4FEBA43B_Out_3);
                XZ_2 = (float4(_Branch_4FEBA43B_Out_3, 0.0, 1.0));
            }
            
            
            inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
            {
                return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
            }
            
            inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
            {
                return (1.0-t)*a + (t*b);
            }
            
            
            inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
            {
                float2 i = floor(uv);
                float2 f = frac(uv);
                f = f * f * (3.0 - 2.0 * f);
            
                uv = abs(frac(uv) - 0.5);
                float2 c0 = i + float2(0.0, 0.0);
                float2 c1 = i + float2(1.0, 0.0);
                float2 c2 = i + float2(0.0, 1.0);
                float2 c3 = i + float2(1.0, 1.0);
                float r0 = Unity_SimpleNoise_RandomValue_float(c0);
                float r1 = Unity_SimpleNoise_RandomValue_float(c1);
                float r2 = Unity_SimpleNoise_RandomValue_float(c2);
                float r3 = Unity_SimpleNoise_RandomValue_float(c3);
            
                float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
                float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
                float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
                return t;
            }
            void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
            {
                float t = 0.0;
            
                float freq = pow(2.0, float(0));
                float amp = pow(0.5, float(3-0));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                freq = pow(2.0, float(1));
                amp = pow(0.5, float(3-1));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                freq = pow(2.0, float(2));
                amp = pow(0.5, float(3-2));
                t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;
            
                Out = t;
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
            }
            
            // 1ab7832f84992b571d2fa80a089d3a8e
            #include "Assets/NatureManufacture Assets/Object Shaders/NMParallaxLayers.hlsl"
            
            void Unity_Blend_Lighten_float4(float4 Base, float4 Blend, out float4 Out, float Opacity)
            {
                Out = max(Blend, Base);
                Out = lerp(Base, Out, Opacity);
            }
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Contrast_float(float3 In, float Contrast, out float3 Out)
            {
                float midpoint = pow(0.5, 2.2);
                Out =  (In - midpoint) * Contrast + midpoint;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_SquareRoot_float4(float4 In, out float4 Out)
            {
                Out = sqrt(In);
            }
            
            void Unity_Sign_float(float In, out float Out)
            {
                Out = sign(In);
            }
            
            void Unity_Ceiling_float(float In, out float Out)
            {
                Out = ceil(In);
            }
            
            struct Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2
            {
            };
            
            void SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(float4 Color_9AA111D3, float Vector1_FBE622A2, float Vector1_8C15C351, Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 IN, out float3 OutVector4_1)
            {
                float4 _Property_90A62E4E_Out_0 = Color_9AA111D3;
                float4 _SquareRoot_51430F5B_Out_1;
                Unity_SquareRoot_float4(_Property_90A62E4E_Out_0, _SquareRoot_51430F5B_Out_1);
                float _Property_4C27E21E_Out_0 = Vector1_FBE622A2;
                float _Sign_2EB7E10D_Out_1;
                Unity_Sign_float(_Property_4C27E21E_Out_0, _Sign_2EB7E10D_Out_1);
                float _Add_29F1B1C0_Out_2;
                Unity_Add_float(_Sign_2EB7E10D_Out_1, 1, _Add_29F1B1C0_Out_2);
                float _Multiply_E5F6C023_Out_2;
                Unity_Multiply_float(_Add_29F1B1C0_Out_2, 0.5, _Multiply_E5F6C023_Out_2);
                float _Ceiling_85D24F96_Out_1;
                Unity_Ceiling_float(_Multiply_E5F6C023_Out_2, _Ceiling_85D24F96_Out_1);
                float _Property_33C740F_Out_0 = Vector1_8C15C351;
                float _Multiply_ED89DC5B_Out_2;
                Unity_Multiply_float(_Property_33C740F_Out_0, _Property_33C740F_Out_0, _Multiply_ED89DC5B_Out_2);
                float4 _Lerp_CA077B77_Out_3;
                Unity_Lerp_float4(_SquareRoot_51430F5B_Out_1, (_Ceiling_85D24F96_Out_1.xxxx), (_Multiply_ED89DC5B_Out_2.xxxx), _Lerp_CA077B77_Out_3);
                float4 _Multiply_9305D041_Out_2;
                Unity_Multiply_float(_Lerp_CA077B77_Out_3, _Lerp_CA077B77_Out_3, _Multiply_9305D041_Out_2);
                OutVector4_1 = (_Multiply_9305D041_Out_2.xyz);
            }
            
            void Unity_Clamp_float4(float4 In, float4 Min, float4 Max, out float4 Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_DotProduct_float2(float2 A, float2 B, out float Out)
            {
                Out = dot(A, B);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_SquareRoot_float(float In, out float Out)
            {
                Out = sqrt(In);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Normalize_float3(float3 In, out float3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            struct Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 AbsoluteWorldSpacePosition;
                half4 uv0;
            };
            
            void SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float4 Vector4_82674548, float Boolean_9FF42DF6, Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 IN, out float4 XZ_2)
            {
                float _Property_EECC5191_Out_0 = Boolean_9FF42DF6;
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float4 _Property_3C0E791E_Out_0 = Vector4_82674548;
                float _Split_BDB607D3_R_1 = _Property_3C0E791E_Out_0[0];
                float _Split_BDB607D3_G_2 = _Property_3C0E791E_Out_0[1];
                float _Split_BDB607D3_B_3 = _Property_3C0E791E_Out_0[2];
                float _Split_BDB607D3_A_4 = _Property_3C0E791E_Out_0[3];
                float _Divide_99B56138_Out_2;
                Unity_Divide_float(1, _Split_BDB607D3_R_1, _Divide_99B56138_Out_2);
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Divide_99B56138_Out_2.xxxx), _Multiply_D99671F1_Out_2);
                float2 _Vector2_870D34BF_Out_0 = float2(_Split_BDB607D3_R_1, _Split_BDB607D3_G_2);
                float2 _Vector2_9D160F08_Out_0 = float2(_Split_BDB607D3_B_3, _Split_BDB607D3_A_4);
                float2 _TilingAndOffset_C775B36F_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_870D34BF_Out_0, _Vector2_9D160F08_Out_0, _TilingAndOffset_C775B36F_Out_3);
                float2 _Branch_F57F5E8_Out_3;
                Unity_Branch_float2(_Property_EECC5191_Out_0, (_Multiply_D99671F1_Out_2.xy), _TilingAndOffset_C775B36F_Out_3, _Branch_F57F5E8_Out_3);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Branch_F57F5E8_Out_3);
                _SampleTexture2D_AF934D9A_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AF934D9A_RGBA_0);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float2 _Vector2_699A5DA1_Out_0 = float2(_SampleTexture2D_AF934D9A_R_4, _SampleTexture2D_AF934D9A_G_5);
                float3 _Sign_937BD7C4_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_937BD7C4_Out_1);
                float _Split_A88C5CBA_R_1 = _Sign_937BD7C4_Out_1[0];
                float _Split_A88C5CBA_G_2 = _Sign_937BD7C4_Out_1[1];
                float _Split_A88C5CBA_B_3 = _Sign_937BD7C4_Out_1[2];
                float _Split_A88C5CBA_A_4 = 0;
                float2 _Vector2_DC7A07A_Out_0 = float2(_Split_A88C5CBA_G_2, 1);
                float2 _Multiply_5A3A785C_Out_2;
                Unity_Multiply_float(_Vector2_699A5DA1_Out_0, _Vector2_DC7A07A_Out_0, _Multiply_5A3A785C_Out_2);
                float _Split_CE0AB7C6_R_1 = IN.WorldSpaceNormal[0];
                float _Split_CE0AB7C6_G_2 = IN.WorldSpaceNormal[1];
                float _Split_CE0AB7C6_B_3 = IN.WorldSpaceNormal[2];
                float _Split_CE0AB7C6_A_4 = 0;
                float2 _Vector2_D40FA1D3_Out_0 = float2(_Split_CE0AB7C6_R_1, _Split_CE0AB7C6_B_3);
                float2 _Add_E4BBD98D_Out_2;
                Unity_Add_float2(_Multiply_5A3A785C_Out_2, _Vector2_D40FA1D3_Out_0, _Add_E4BBD98D_Out_2);
                float _Split_1D7F6EE9_R_1 = _Add_E4BBD98D_Out_2[0];
                float _Split_1D7F6EE9_G_2 = _Add_E4BBD98D_Out_2[1];
                float _Split_1D7F6EE9_B_3 = 0;
                float _Split_1D7F6EE9_A_4 = 0;
                float _Multiply_D1C95945_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_B_6, _Split_CE0AB7C6_G_2, _Multiply_D1C95945_Out_2);
                float3 _Vector3_CB17D4AB_Out_0 = float3(_Split_1D7F6EE9_R_1, _Multiply_D1C95945_Out_2, _Split_1D7F6EE9_G_2);
                float3x3 Transform_D163BAD_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_D163BAD_Out_1 = TransformWorldToTangent(_Vector3_CB17D4AB_Out_0.xyz, Transform_D163BAD_tangentTransform_World);
                float3 _Normalize_49BB8375_Out_1;
                Unity_Normalize_float3(_Transform_D163BAD_Out_1, _Normalize_49BB8375_Out_1);
                float3 _Branch_CB8BD7A6_Out_3;
                Unity_Branch_float3(_Property_EECC5191_Out_0, _Normalize_49BB8375_Out_1, (_SampleTexture2D_AF934D9A_RGBA_0.xyz), _Branch_CB8BD7A6_Out_3);
                XZ_2 = (float4(_Branch_CB8BD7A6_Out_3, 1.0));
            }
            
            void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
            {
                Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceBiTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceViewDirection;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 AbsoluteWorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3E4B16C8_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F2A4C04A_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_605BEBB1;
                _PlanarNM_605BEBB1.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_605BEBB1.uv0 = IN.uv0;
                float4 _PlanarNM_605BEBB1_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNM_605BEBB1, _PlanarNM_605BEBB1_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F69A7540_Out_0 = _IceParallaxSteps;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151 _PlanarNMparallax_19C7D294;
                _PlanarNMparallax_19C7D294.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMparallax_19C7D294.uv0 = IN.uv0;
                float4 _PlanarNMparallax_19C7D294_XZ_2;
                SG_PlanarNMparallax_8f4c0780863a32842bb34cdaf7eda151(_Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMparallax_19C7D294, _PlanarNMparallax_19C7D294_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_584447FF_Out_0 = _ParalaxOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_25AD48E5_Out_0 = _IceParallaxNoiseMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_98575B71_Out_0 = _IceParallaxNoiseMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_16DB2C3A_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_16DB2C3A_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_16DB2C3A_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_16DB2C3A_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_BE79C1A8_Out_0 = float2(_Split_16DB2C3A_R_1, _Split_16DB2C3A_B_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_543B17EA_Out_0 = _IceParallaxNoiseScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SimpleNoise_CCF200D9_Out_2;
                Unity_SimpleNoise_float(_Vector2_BE79C1A8_Out_0, _Property_543B17EA_Out_0, _SimpleNoise_CCF200D9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_5C49F379_Out_3;
                Unity_Lerp_float(_Property_25AD48E5_Out_0, _Property_98575B71_Out_0, _SimpleNoise_CCF200D9_Out_2, _Lerp_5C49F379_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_A34AA065_Out_3;
                Unity_Lerp_float(_Property_584447FF_Out_0, 0, _Lerp_5C49F379_Out_3, _Lerp_A34AA065_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_36F6A6D0_Out_0 = _IceDepth;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3x3 Transform_D9CFEC5_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_D9CFEC5_Out_1 = TransformWorldToTangent(IN.WorldSpaceViewDirection.xyz, Transform_D9CFEC5_tangentTransform_World);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_39D230AF_Out_0 = _ParallaxFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_ED48CB71_Out_3;
                Unity_Lerp_float(_Property_39D230AF_Out_0, 0, _Lerp_5C49F379_Out_3, _Lerp_ED48CB71_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _CustomFunction_92A39E95_Out_2;
                ParallaxLayers_float(_Property_F69A7540_Out_0, (_PlanarNMparallax_19C7D294_XZ_2.xy), _Lerp_A34AA065_Out_3, _Property_36F6A6D0_Out_0, _Transform_D9CFEC5_Out_1, IN.WorldSpaceViewDirection, _Lerp_ED48CB71_Out_3, _Property_F2A4C04A_Out_0, _CustomFunction_92A39E95_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Blend_F08AFA54_Out_2;
                Unity_Blend_Lighten_float4(_PlanarNM_605BEBB1_XZ_2, _CustomFunction_92A39E95_Out_2, _Blend_F08AFA54_Out_2, _Property_39D230AF_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_C4180B07_Out_0 = _DeepColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2896096E_Out_0 = _IceNoiseScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SimpleNoise_608BDE5D_Out_2;
                Unity_SimpleNoise_float(_Vector2_BE79C1A8_Out_0, _Property_2896096E_Out_0, _SimpleNoise_608BDE5D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_39A6A18_Out_1;
                Unity_Absolute_float(_SimpleNoise_608BDE5D_Out_2, _Absolute_39A6A18_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F52DBFE9_Out_0 = _IceNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Power_3A1C69E3_Out_2;
                Unity_Power_float(_Absolute_39A6A18_Out_1, _Property_F52DBFE9_Out_0, _Power_3A1C69E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C2BBB8DB_Out_0 = _IceNoiseContrast;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Contrast_D1EA0699_Out_2;
                Unity_Contrast_float((_Power_3A1C69E3_Out_2.xxx), _Property_C2BBB8DB_Out_0, _Contrast_D1EA0699_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9D04AA67_R_1 = _Contrast_D1EA0699_Out_2[0];
                float _Split_9D04AA67_G_2 = _Contrast_D1EA0699_Out_2[1];
                float _Split_9D04AA67_B_3 = _Contrast_D1EA0699_Out_2[2];
                float _Split_9D04AA67_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_7C8D44C6_Out_3;
                Unity_Clamp_float(_Split_9D04AA67_R_1, 0, 1, _Clamp_7C8D44C6_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Lerp_10B48734_Out_3;
                Unity_Lerp_float4(_Blend_F08AFA54_Out_2, _Property_C4180B07_Out_0, (_Clamp_7C8D44C6_Out_3.xxxx), _Lerp_10B48734_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3D23ECB5_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_3B5A4F3A_Out_2;
                Unity_Multiply_float(_Lerp_10B48734_Out_3, _Property_3D23ECB5_Out_0, _Multiply_3B5A4F3A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_FC905A02_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_66FEB2D6_R_1 = _Property_FC905A02_Out_0[0];
                float _Split_66FEB2D6_G_2 = _Property_FC905A02_Out_0[1];
                float _Split_66FEB2D6_B_3 = _Property_FC905A02_Out_0[2];
                float _Split_66FEB2D6_A_4 = _Property_FC905A02_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_2C65450F_Out_0 = float2(_Split_66FEB2D6_R_1, _Split_66FEB2D6_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_20821B1B_Out_0 = float2(_Split_66FEB2D6_B_3, _Split_66FEB2D6_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_AFDF49A5_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_2C65450F_Out_0, _Vector2_20821B1B_Out_0, _TilingAndOffset_AFDF49A5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_CD9C50D2_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_AFDF49A5_Out_3);
                float _SampleTexture2D_CD9C50D2_R_4 = _SampleTexture2D_CD9C50D2_RGBA_0.r;
                float _SampleTexture2D_CD9C50D2_G_5 = _SampleTexture2D_CD9C50D2_RGBA_0.g;
                float _SampleTexture2D_CD9C50D2_B_6 = _SampleTexture2D_CD9C50D2_RGBA_0.b;
                float _SampleTexture2D_CD9C50D2_A_7 = _SampleTexture2D_CD9C50D2_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_6CEB2199_Out_2;
                Unity_Multiply_float(_SampleTexture2D_CD9C50D2_R_4, 2, _Multiply_6CEB2199_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_81546154_Out_2;
                Unity_Add_float(_Multiply_6CEB2199_Out_2, -1, _Add_81546154_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2152BC92_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_4FF44BF6_Out_2;
                Unity_Multiply_float(_Add_81546154_Out_2, _Property_2152BC92_Out_0, _Multiply_4FF44BF6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_44A6B3E6_Out_1;
                Unity_Saturate_float(_Multiply_4FF44BF6_Out_2, _Saturate_44A6B3E6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_252B9168_Out_1;
                Unity_Absolute_float(_Saturate_44A6B3E6_Out_1, _Absolute_252B9168_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_DC11EFE2;
                float3 _BlendOverlayBaseColor_DC11EFE2_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_3B5A4F3A_Out_2, _Add_81546154_Out_2, _Absolute_252B9168_Out_1, _BlendOverlayBaseColor_DC11EFE2, _BlendOverlayBaseColor_DC11EFE2_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_E0773BA3_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6388FCB5_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_37241974;
                _PlanarNM_37241974.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_37241974.uv0 = IN.uv0;
                float4 _PlanarNM_37241974_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNM_37241974, _PlanarNM_37241974_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_AF2EEB1D_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_64C7F396_Out_2;
                Unity_Multiply_float(_PlanarNM_37241974_XZ_2, _Property_AF2EEB1D_Out_0, _Multiply_64C7F396_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_23C9E59F_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_A42D1072_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_23C9E59F_Out_0.xy));
                float _SampleTexture2D_A42D1072_R_4 = _SampleTexture2D_A42D1072_RGBA_0.r;
                float _SampleTexture2D_A42D1072_G_5 = _SampleTexture2D_A42D1072_RGBA_0.g;
                float _SampleTexture2D_A42D1072_B_6 = _SampleTexture2D_A42D1072_RGBA_0.b;
                float _SampleTexture2D_A42D1072_A_7 = _SampleTexture2D_A42D1072_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_23BACCE9_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_E1E6CA0C_Out_2;
                Unity_Multiply_float(_SampleTexture2D_A42D1072_A_7, _Property_23BACCE9_Out_0, _Multiply_E1E6CA0C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_E47EFF9E_Out_3;
                Unity_Clamp_float(_Multiply_E1E6CA0C_Out_2, 0, 1, _Clamp_E47EFF9E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Clamp_93A41266_Out_3;
                Unity_Clamp_float4(IN.VertexColor, float4(0, 0, 0, 0), float4(1, 1, 1, 1), _Clamp_93A41266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A30F99_R_1 = _Clamp_93A41266_Out_3[0];
                float _Split_A30F99_G_2 = _Clamp_93A41266_Out_3[1];
                float _Split_A30F99_B_3 = _Clamp_93A41266_Out_3[2];
                float _Split_A30F99_A_4 = _Clamp_93A41266_Out_3[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_D25079B9_Out_0 = float2(_SampleTexture2D_CD9C50D2_A_7, _SampleTexture2D_CD9C50D2_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_A6D263CC_Out_2;
                Unity_Multiply_float(_Vector2_D25079B9_Out_0, float2(2, 2), _Multiply_A6D263CC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_A94F92F2_Out_2;
                Unity_Add_float2(_Multiply_A6D263CC_Out_2, float2(-1, -1), _Add_A94F92F2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_5A04D61A_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_E3BBD5A0_Out_2;
                Unity_Multiply_float(_Add_A94F92F2_Out_2, (_Property_5A04D61A_Out_0.xx), _Multiply_E3BBD5A0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_3BC0AA96_R_1 = _Multiply_E3BBD5A0_Out_2[0];
                float _Split_3BC0AA96_G_2 = _Multiply_E3BBD5A0_Out_2[1];
                float _Split_3BC0AA96_B_3 = 0;
                float _Split_3BC0AA96_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _DotProduct_9FB0B73C_Out_2;
                Unity_DotProduct_float2(_Multiply_E3BBD5A0_Out_2, _Multiply_E3BBD5A0_Out_2, _DotProduct_9FB0B73C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_3C8C4A9B_Out_1;
                Unity_Saturate_float(_DotProduct_9FB0B73C_Out_2, _Saturate_3C8C4A9B_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_E0A2EC16_Out_1;
                Unity_OneMinus_float(_Saturate_3C8C4A9B_Out_1, _OneMinus_E0A2EC16_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _SquareRoot_7D6FC55F_Out_1;
                Unity_SquareRoot_float(_OneMinus_E0A2EC16_Out_1, _SquareRoot_7D6FC55F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Vector3_408E9F99_Out_0 = float3(_Split_3BC0AA96_R_1, _Split_3BC0AA96_G_2, _SquareRoot_7D6FC55F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_F0D9C40B;
                _PlanarNMn_F0D9C40B.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_F0D9C40B.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_F0D9C40B.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_F0D9C40B.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_F0D9C40B.uv0 = IN.uv0;
                float4 _PlanarNMn_F0D9C40B_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMn_F0D9C40B, _PlanarNMn_F0D9C40B_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1CABD952_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_EDF1EB8B_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_F0D9C40B_XZ_2.xyz), _Property_1CABD952_Out_0, _NormalStrength_EDF1EB8B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_B7F72910;
                _PlanarNMn_B7F72910.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_B7F72910.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_B7F72910.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_B7F72910.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_B7F72910.uv0 = IN.uv0;
                float4 _PlanarNMn_B7F72910_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_IceNoiseNormal, sampler_IceNoiseNormal), _IceNoiseNormal_TexelSize, _Property_3E4B16C8_Out_0, _Property_F2A4C04A_Out_0, _PlanarNMn_B7F72910, _PlanarNMn_B7F72910_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_3E79A67D_Out_0 = _NoiseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_DC5D8477_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_B7F72910_XZ_2.xyz), _Property_3E79A67D_Out_0, _NormalStrength_DC5D8477_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_13B2C2D_Out_3;
                Unity_Lerp_float3(_NormalStrength_EDF1EB8B_Out_2, _NormalStrength_DC5D8477_Out_2, (_Clamp_7C8D44C6_Out_3.xxx), _Lerp_13B2C2D_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalBlend_24C86B99_Out_2;
                Unity_NormalBlend_float(_Vector3_408E9F99_Out_0, _Lerp_13B2C2D_Out_3, _NormalBlend_24C86B99_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_82A01385;
                _PlanarNMn_82A01385.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_82A01385.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_82A01385.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_82A01385.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_82A01385.uv0 = IN.uv0;
                float4 _PlanarNMn_82A01385_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNMn_82A01385, _PlanarNMn_82A01385_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_2BC6CE93_Out_0 = _CoverNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_EE9C3A89_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_82A01385_XZ_2.xyz), _Property_2BC6CE93_Out_0, _NormalStrength_EE9C3A89_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_285FA03B_R_1 = IN.WorldSpaceNormal[0];
                float _Split_285FA03B_G_2 = IN.WorldSpaceNormal[1];
                float _Split_285FA03B_B_3 = IN.WorldSpaceNormal[2];
                float _Split_285FA03B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_A78EDC1C_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9F8A8080_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_F2912DD5_Out_2;
                Unity_Subtract_float(4, _Property_9F8A8080_Out_0, _Subtract_F2912DD5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_D14A542B_Out_2;
                Unity_Divide_float(_Property_A78EDC1C_Out_0, _Subtract_F2912DD5_Out_2, _Divide_D14A542B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_CBDEAEC6_Out_1;
                Unity_Absolute_float(_Divide_D14A542B_Out_2, _Absolute_CBDEAEC6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_468546B2_Out_2;
                Unity_Power_float(_Absolute_CBDEAEC6_Out_1, _Subtract_F2912DD5_Out_2, _Power_468546B2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_505BD7CB_Out_3;
                Unity_Clamp_float(_Power_468546B2_Out_2, 0, 2, _Clamp_505BD7CB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_C557E9AF_Out_2;
                Unity_Multiply_float(_Split_285FA03B_G_2, _Clamp_505BD7CB_Out_3, _Multiply_C557E9AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_AAEFC124_Out_1;
                Unity_Saturate_float(_Multiply_C557E9AF_Out_2, _Saturate_AAEFC124_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_FE0E6938_Out_3;
                Unity_Clamp_float(_Split_285FA03B_G_2, 0, 0.9999, _Clamp_FE0E6938_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9FAF9E79_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_C024499C_Out_2;
                Unity_Divide_float(_Property_9FAF9E79_Out_0, 45, _Divide_C024499C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_819C6AF2_Out_1;
                Unity_OneMinus_float(_Divide_C024499C_Out_2, _OneMinus_819C6AF2_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_E0C6446E_Out_2;
                Unity_Subtract_float(_Clamp_FE0E6938_Out_3, _OneMinus_819C6AF2_Out_1, _Subtract_E0C6446E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_9DD83AC8_Out_3;
                Unity_Clamp_float(_Subtract_E0C6446E_Out_2, 0, 2, _Clamp_9DD83AC8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_FA29401D_Out_2;
                Unity_Divide_float(1, _Divide_C024499C_Out_2, _Divide_FA29401D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_4D0D7B0_Out_2;
                Unity_Multiply_float(_Clamp_9DD83AC8_Out_3, _Divide_FA29401D_Out_2, _Multiply_4D0D7B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_128CA3C3_Out_1;
                Unity_Absolute_float(_Multiply_4D0D7B0_Out_2, _Absolute_128CA3C3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_CFA12E7D_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_5ED343D8_Out_2;
                Unity_Power_float(_Absolute_128CA3C3_Out_1, _Property_CFA12E7D_Out_0, _Power_5ED343D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_3BC73AD4_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_5124E5F6_Out_1;
                Unity_OneMinus_float(_Property_3BC73AD4_Out_0, _OneMinus_5124E5F6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_2735CEFA_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_2735CEFA_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_2735CEFA_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_2735CEFA_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_ED205FBF_Out_2;
                Unity_Add_float(_OneMinus_5124E5F6_Out_1, _Split_2735CEFA_G_2, _Add_ED205FBF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_752AF7A2_Out_2;
                Unity_Add_float(_Add_ED205FBF_Out_2, 1, _Add_752AF7A2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_E090F386_Out_3;
                Unity_Clamp_float(_Add_752AF7A2_Out_2, 0, 1, _Clamp_E090F386_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_73B1AD10_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_331D8064_Out_2;
                Unity_Add_float(_Add_ED205FBF_Out_2, _Property_73B1AD10_Out_0, _Add_331D8064_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_CB58FE2E_Out_2;
                Unity_Divide_float(_Add_331D8064_Out_2, _Add_ED205FBF_Out_2, _Divide_CB58FE2E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1ABEFCE6_Out_1;
                Unity_OneMinus_float(_Divide_CB58FE2E_Out_2, _OneMinus_1ABEFCE6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_8F137BF7_Out_2;
                Unity_Add_float(_OneMinus_1ABEFCE6_Out_1, -0.5, _Add_8F137BF7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_35395974_Out_3;
                Unity_Clamp_float(_Add_8F137BF7_Out_2, 0, 1, _Clamp_35395974_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DC8DD517_Out_2;
                Unity_Add_float(_Clamp_E090F386_Out_3, _Clamp_35395974_Out_3, _Add_DC8DD517_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_978A71EF_Out_3;
                Unity_Clamp_float(_Add_DC8DD517_Out_2, 0, 1, _Clamp_978A71EF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_85C9E9EE_Out_2;
                Unity_Multiply_float(_Power_5ED343D8_Out_2, _Clamp_978A71EF_Out_3, _Multiply_85C9E9EE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D14C5FA5_Out_2;
                Unity_Multiply_float(_Saturate_AAEFC124_Out_1, _Multiply_85C9E9EE_Out_2, _Multiply_D14C5FA5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_B3376A42_Out_3;
                Unity_Lerp_float3(_NormalBlend_24C86B99_Out_2, _NormalStrength_EE9C3A89_Out_2, (_Multiply_D14C5FA5_Out_2.xxx), _Lerp_B3376A42_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_D1A2C0A3_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_D1A2C0A3_Out_1 = mul(Transform_D1A2C0A3_transposeTangent, _Lerp_B3376A42_Out_3.xyz).xyz;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_B0D440A_R_1 = _Transform_D1A2C0A3_Out_1[0];
                float _Split_B0D440A_G_2 = _Transform_D1A2C0A3_Out_1[1];
                float _Split_B0D440A_B_3 = _Transform_D1A2C0A3_Out_1[2];
                float _Split_B0D440A_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_730C1F53_Out_2;
                Unity_Multiply_float(_Split_B0D440A_G_2, _Clamp_505BD7CB_Out_3, _Multiply_730C1F53_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_B2B3901D_Out_2;
                Unity_Multiply_float(_Clamp_505BD7CB_Out_3, _Property_CFA12E7D_Out_0, _Multiply_B2B3901D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_A7C78B4E_Out_2;
                Unity_Multiply_float(_Multiply_B2B3901D_Out_2, _Multiply_85C9E9EE_Out_2, _Multiply_A7C78B4E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_A9771D5F_Out_2;
                Unity_Multiply_float(_Multiply_730C1F53_Out_2, _Multiply_A7C78B4E_Out_2, _Multiply_A9771D5F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_1C1C26F9;
                _PlanarNM_1C1C26F9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_1C1C26F9.uv0 = IN.uv0;
                float4 _PlanarNM_1C1C26F9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_E0773BA3_Out_0, _Property_6388FCB5_Out_0, _PlanarNM_1C1C26F9, _PlanarNM_1C1C26F9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_C5FA0079_R_1 = _PlanarNM_1C1C26F9_XZ_2[0];
                float _Split_C5FA0079_G_2 = _PlanarNM_1C1C26F9_XZ_2[1];
                float _Split_C5FA0079_B_3 = _PlanarNM_1C1C26F9_XZ_2[2];
                float _Split_C5FA0079_A_4 = _PlanarNM_1C1C26F9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_79C0622E_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_F9B7976A_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_2075ED8D_Out_0 = float2(_Property_79C0622E_Out_0, _Property_F9B7976A_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_39A9ADEC_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_DFDDD509_Out_2;
                Unity_Add_float2(_Vector2_2075ED8D_Out_0, (_Property_39A9ADEC_Out_0.xx), _Add_DFDDD509_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_64922366_Out_3;
                Unity_Remap_float(_Split_C5FA0079_B_3, float2 (0, 1), _Add_DFDDD509_Out_2, _Remap_64922366_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5DF35CED_Out_2;
                Unity_Multiply_float(_Multiply_A9771D5F_Out_2, _Remap_64922366_Out_3, _Multiply_5DF35CED_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_46650FF2_Out_2;
                Unity_Multiply_float(_Split_A30F99_G_2, _Multiply_5DF35CED_Out_2, _Multiply_46650FF2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_A6088ECC_Out_1;
                Unity_Saturate_float(_Multiply_46650FF2_Out_2, _Saturate_A6088ECC_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_FDFD4BAD_Out_2;
                Unity_Multiply_float(_Clamp_E47EFF9E_Out_3, _Saturate_A6088ECC_Out_1, _Multiply_FDFD4BAD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_6DA1DCFE_Out_3;
                Unity_Clamp_float(_Multiply_FDFD4BAD_Out_2, 0, 1, _Clamp_6DA1DCFE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_11641B3F_Out_0 = _Clamp_6DA1DCFE_Out_3;
                #else
                float _UseDynamicCoverTStaticMaskF_11641B3F_Out_0 = _Clamp_E47EFF9E_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_8BDA8462_Out_3;
                Unity_Clamp_float(_UseDynamicCoverTStaticMaskF_11641B3F_Out_0, 0, 1, _Clamp_8BDA8462_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_6387F1BD_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_DC11EFE2_OutVector4_1, (_Multiply_64C7F396_Out_2.xyz), (_Clamp_8BDA8462_Out_3.xxx), _Lerp_6387F1BD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_FCA5654_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_8F3F0743_Out_2;
                Unity_Multiply_float((_Property_FCA5654_Out_0.xyz), _Lerp_6387F1BD_Out_3, _Multiply_8F3F0743_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_3E465E6D_Out_1;
                Unity_OneMinus_float(_Split_A30F99_R_1, _OneMinus_3E465E6D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_D3906CE2_Out_3;
                Unity_Lerp_float3(_Lerp_6387F1BD_Out_3, _Multiply_8F3F0743_Out_2, (_OneMinus_3E465E6D_Out_1.xxx), _Lerp_D3906CE2_Out_3);
                #endif
                surface.Albedo = _Lerp_D3906CE2_Out_3;
                surface.Alpha = 1;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0 : TEXCOORD0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_Position;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 viewDirectionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 bitangentWS;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_Position;
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
                float3 interp05 : TEXCOORD5;
                float3 interp06 : TEXCOORD6;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.color;
                output.interp05.xyz = input.viewDirectionWS;
                output.interp06.xyz = input.bitangentWS;
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
                Varyings output;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.color = input.interp04.xyzw;
                output.viewDirectionWS = input.interp05.xyz;
                output.bitangentWS = input.interp06.xyz;
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
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            input.normalWS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceTangent =           input.tangentWS.xyz;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceBiTangent =         input.bitangentWS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
            #endif
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
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
    FallBack "Hidden/Shader Graph/FallbackError"
}
