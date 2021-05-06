Shader "NatureManufacture/URP/Lit/Specular Triplanar Cover"
{
    Properties
    {
        _AlphaCutoff("Alpha Cutoff", Range(0, 1)) = 0
        _BaseColor("Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_BaseColorMap("Base Map(RGB) Alpha(A)", 2D) = "white" {}
        [ToggleUI]_BaseUsePlanarUV("Base Use Planar UV", Float) = 0
        _BaseTilingOffset("Base Tiling and Offset", Vector) = (1, 1, 0, 0)
        _SpecularColor("Specular Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_SpecularColorMap("Specular Map", 2D) = "white" {}
        [NoScaleOffset]_BaseNormalMap("Base Normal Map", 2D) = "bump" {}
        _BaseNormalScale("Base Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_BaseMaskMap("Base Mask Map AO(G) SM(A)", 2D) = "white" {}
        _BaseAORemapMin("Base AO Remap Min", Range(0, 1)) = 0
        _BaseAORemapMax("Base AO Remap Max", Range(0, 1)) = 1
        _BaseSmoothnessRemapMin("Base Smoothness Remap Min", Range(0, 1)) = 0
        _BaseSmoothnessRemapMax("Base Smoothness Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_CoverMaskA("Cover Mask (A)", 2D) = "white" {}
        _CoverMaskPower("Cover Mask Power", Range(0, 10)) = 1
        _Cover_Amount("Cover Amount", Range(0, 2)) = 0
        _Cover_Amount_Grow_Speed("Cover Amount Grow Speed", Range(0, 3)) = 3
        _CoverDirection("Cover Direction", Vector) = (0, 1, 0, 0)
        _Cover_Max_Angle("Cover Max Angle", Range(0.001, 90)) = 35
        _Cover_Min_Height("Cover Min Height", Float) = -10000
        _Cover_Min_Height_Blending("Cover Min Height Blending", Range(0, 500)) = 1
        _CoverBaseColor("Cover Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_CoverBaseColorMap("Cover Base Map", 2D) = "white" {}
        _CoverTilingOffset("Cover Tiling Offset", Vector) = (1, 1, 0, 0)
        _CoverTriplanarThreshold("Cover Triplanar Threshold", Range(1, 8)) = 5
        _CoverSpecularColor("Cover Specular Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_CoverSpecularColorMap("Cover Specular Map", 2D) = "white" {}
        [NoScaleOffset]_CoverNormalMap("Cover Normal Map", 2D) = "bump" {}
        _CoverNormalScale("Cover Normal Scale", Range(0, 8)) = 1
        _CoverNormalBlendHardness("Cover Normal Blend Hardness", Range(0, 8)) = 1
        _CoverHardness("Cover Hardness", Range(0, 10)) = 5
        _CoverHeightMapMin("Cover Height Map Min", Float) = 0
        _CoverHeightMapMax("Cover Height Map Max", Float) = 1
        _CoverHeightMapOffset("Cover Height Map Offset", Float) = 0
        [NoScaleOffset]_CoverMaskMap("Cover Mask Map AO(G) H(B) SM(A)", 2D) = "white" {}
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
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
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
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif
        
        
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_FORWARD
        
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
            float _AlphaCutoff;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float4 _SpecularColor;
            float _BaseNormalScale;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float3 _CoverDirection;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverTriplanarThreshold;
            float4 _CoverSpecularColor;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
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
            TEXTURE2D(_SpecularColorMap); SAMPLER(sampler_SpecularColorMap); float4 _SpecularColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverSpecularColorMap); SAMPLER(sampler_CoverSpecularColorMap); float4 _CoverSpecularColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_5927C7C9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_66E4959F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_96366F41_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_3E2881E2_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // c7f63929085c93b4f2216b914e6e81d6
            #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
            {
            };
            
            void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
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
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
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
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
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
            
            void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A / B;
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Absolute_float3(float3 In, out float3 Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float3(float3 A, float3 B, out float3 Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A + B;
            }
            
            struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
            {
                float3 WorldSpaceNormal;
                float3 AbsoluteWorldSpacePosition;
            };
            
            void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
            {
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float _Property_7A4DC59B_Out_0 = Vector1_41461AC9;
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_D99671F1_Out_2);
                float3 _Sign_C0850857_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_C0850857_Out_1);
                float _Split_EEBC69B5_R_1 = _Sign_C0850857_Out_1[0];
                float _Split_EEBC69B5_G_2 = _Sign_C0850857_Out_1[1];
                float _Split_EEBC69B5_B_3 = _Sign_C0850857_Out_1[2];
                float _Split_EEBC69B5_A_4 = 0;
                float2 _Vector2_7598EA98_Out_0 = float2(_Split_EEBC69B5_G_2, 1);
                float2 _Multiply_F82F3FE2_Out_2;
                Unity_Multiply_float((_Multiply_D99671F1_Out_2.xy), _Vector2_7598EA98_Out_0, _Multiply_F82F3FE2_Out_2);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_F82F3FE2_Out_2);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float3 _Absolute_FF95EDEB_Out_1;
                Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_FF95EDEB_Out_1);
                float _Property_F8688E0_Out_0 = Vector1_E4D1C13A;
                float3 _Power_C741CD3A_Out_2;
                Unity_Power_float3(_Absolute_FF95EDEB_Out_1, (_Property_F8688E0_Out_0.xxx), _Power_C741CD3A_Out_2);
                float3 _Multiply_3FB4A346_Out_2;
                Unity_Multiply_float(_Power_C741CD3A_Out_2, _Power_C741CD3A_Out_2, _Multiply_3FB4A346_Out_2);
                float _Split_98088E33_R_1 = _Multiply_3FB4A346_Out_2[0];
                float _Split_98088E33_G_2 = _Multiply_3FB4A346_Out_2[1];
                float _Split_98088E33_B_3 = _Multiply_3FB4A346_Out_2[2];
                float _Split_98088E33_A_4 = 0;
                float4 _Multiply_B99FFB12_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_RGBA_0, (_Split_98088E33_G_2.xxxx), _Multiply_B99FFB12_Out_2);
                float4 _Combine_EAF808EA_RGBA_4;
                float3 _Combine_EAF808EA_RGB_5;
                float2 _Combine_EAF808EA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_G_2, 0, 0, _Combine_EAF808EA_RGBA_4, _Combine_EAF808EA_RGB_5, _Combine_EAF808EA_RG_6);
                float4 _Multiply_9B855117_Out_2;
                Unity_Multiply_float(_Combine_EAF808EA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_9B855117_Out_2);
                float _Multiply_B8AC16FB_Out_2;
                Unity_Multiply_float(_Split_EEBC69B5_B_3, -1, _Multiply_B8AC16FB_Out_2);
                float2 _Vector2_F031282A_Out_0 = float2(_Multiply_B8AC16FB_Out_2, 1);
                float2 _Multiply_89A39D70_Out_2;
                Unity_Multiply_float((_Multiply_9B855117_Out_2.xy), _Vector2_F031282A_Out_0, _Multiply_89A39D70_Out_2);
                float4 _SampleTexture2D_66E4959F_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_89A39D70_Out_2);
                float _SampleTexture2D_66E4959F_R_4 = _SampleTexture2D_66E4959F_RGBA_0.r;
                float _SampleTexture2D_66E4959F_G_5 = _SampleTexture2D_66E4959F_RGBA_0.g;
                float _SampleTexture2D_66E4959F_B_6 = _SampleTexture2D_66E4959F_RGBA_0.b;
                float _SampleTexture2D_66E4959F_A_7 = _SampleTexture2D_66E4959F_RGBA_0.a;
                float4 _Multiply_9E620CB9_Out_2;
                Unity_Multiply_float(_SampleTexture2D_66E4959F_RGBA_0, (_Split_98088E33_B_3.xxxx), _Multiply_9E620CB9_Out_2);
                float4 _Combine_D494A8E_RGBA_4;
                float3 _Combine_D494A8E_RGB_5;
                float2 _Combine_D494A8E_RG_6;
                Unity_Combine_float(_Split_34F118DC_B_3, _Split_34F118DC_G_2, 0, 0, _Combine_D494A8E_RGBA_4, _Combine_D494A8E_RGB_5, _Combine_D494A8E_RG_6);
                float4 _Multiply_1B29A9F1_Out_2;
                Unity_Multiply_float(_Combine_D494A8E_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_1B29A9F1_Out_2);
                float2 _Vector2_1F147BEC_Out_0 = float2(_Split_EEBC69B5_R_1, 1);
                float2 _Multiply_5B8B54E9_Out_2;
                Unity_Multiply_float((_Multiply_1B29A9F1_Out_2.xy), _Vector2_1F147BEC_Out_0, _Multiply_5B8B54E9_Out_2);
                float4 _SampleTexture2D_96366F41_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5B8B54E9_Out_2);
                float _SampleTexture2D_96366F41_R_4 = _SampleTexture2D_96366F41_RGBA_0.r;
                float _SampleTexture2D_96366F41_G_5 = _SampleTexture2D_96366F41_RGBA_0.g;
                float _SampleTexture2D_96366F41_B_6 = _SampleTexture2D_96366F41_RGBA_0.b;
                float _SampleTexture2D_96366F41_A_7 = _SampleTexture2D_96366F41_RGBA_0.a;
                float4 _Multiply_1C5CFCC5_Out_2;
                Unity_Multiply_float(_SampleTexture2D_96366F41_RGBA_0, (_Split_98088E33_R_1.xxxx), _Multiply_1C5CFCC5_Out_2);
                float4 _Add_D483B2FD_Out_2;
                Unity_Add_float4(_Multiply_9E620CB9_Out_2, _Multiply_1C5CFCC5_Out_2, _Add_D483B2FD_Out_2);
                float4 _Add_166B5BED_Out_2;
                Unity_Add_float4(_Multiply_B99FFB12_Out_2, _Add_D483B2FD_Out_2, _Add_166B5BED_Out_2);
                float _Add_B73B64F6_Out_2;
                Unity_Add_float(_Split_98088E33_R_1, _Split_98088E33_G_2, _Add_B73B64F6_Out_2);
                float _Add_523B36E8_Out_2;
                Unity_Add_float(_Add_B73B64F6_Out_2, _Split_98088E33_B_3, _Add_523B36E8_Out_2);
                float4 _Divide_86C67C72_Out_2;
                Unity_Divide_float4(_Add_166B5BED_Out_2, (_Add_523B36E8_Out_2.xxxx), _Divide_86C67C72_Out_2);
                XYZ_1 = _Divide_86C67C72_Out_2;
                XZ_2 = _SampleTexture2D_AF934D9A_RGBA_0;
                YZ_3 = _SampleTexture2D_66E4959F_RGBA_0;
                XY_4 = _SampleTexture2D_96366F41_RGBA_0;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
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
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A / B;
            }
            
            struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 AbsoluteWorldSpacePosition;
            };
            
            void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
            {
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float _Property_7A4DC59B_Out_0 = Vector1_41461AC9;
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_D99671F1_Out_2);
                float3 _Sign_937BD7C4_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_937BD7C4_Out_1);
                float _Split_A88C5CBA_R_1 = _Sign_937BD7C4_Out_1[0];
                float _Split_A88C5CBA_G_2 = _Sign_937BD7C4_Out_1[1];
                float _Split_A88C5CBA_B_3 = _Sign_937BD7C4_Out_1[2];
                float _Split_A88C5CBA_A_4 = 0;
                float2 _Vector2_DC7A07A_Out_0 = float2(_Split_A88C5CBA_G_2, 1);
                float2 _Multiply_6E58BF97_Out_2;
                Unity_Multiply_float((_Multiply_D99671F1_Out_2.xy), _Vector2_DC7A07A_Out_0, _Multiply_6E58BF97_Out_2);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_6E58BF97_Out_2);
                _SampleTexture2D_AF934D9A_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AF934D9A_RGBA_0);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float2 _Vector2_699A5DA1_Out_0 = float2(_SampleTexture2D_AF934D9A_R_4, _SampleTexture2D_AF934D9A_G_5);
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
                float _Multiply_97283B7E_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_B_6, _Split_CE0AB7C6_G_2, _Multiply_97283B7E_Out_2);
                float3 _Vector3_A5ECB01F_Out_0 = float3(_Split_1D7F6EE9_R_1, _Multiply_97283B7E_Out_2, _Split_1D7F6EE9_G_2);
                float3 _Absolute_FF95EDEB_Out_1;
                Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_FF95EDEB_Out_1);
                float _Property_F8688E0_Out_0 = Vector1_E4D1C13A;
                float3 _Power_C741CD3A_Out_2;
                Unity_Power_float3(_Absolute_FF95EDEB_Out_1, (_Property_F8688E0_Out_0.xxx), _Power_C741CD3A_Out_2);
                float3 _Multiply_3FB4A346_Out_2;
                Unity_Multiply_float(_Power_C741CD3A_Out_2, _Power_C741CD3A_Out_2, _Multiply_3FB4A346_Out_2);
                float _Split_98088E33_R_1 = _Multiply_3FB4A346_Out_2[0];
                float _Split_98088E33_G_2 = _Multiply_3FB4A346_Out_2[1];
                float _Split_98088E33_B_3 = _Multiply_3FB4A346_Out_2[2];
                float _Split_98088E33_A_4 = 0;
                float3 _Multiply_B99FFB12_Out_2;
                Unity_Multiply_float(_Vector3_A5ECB01F_Out_0, (_Split_98088E33_G_2.xxx), _Multiply_B99FFB12_Out_2);
                float4 _Combine_EAF808EA_RGBA_4;
                float3 _Combine_EAF808EA_RGB_5;
                float2 _Combine_EAF808EA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_G_2, 0, 0, _Combine_EAF808EA_RGBA_4, _Combine_EAF808EA_RGB_5, _Combine_EAF808EA_RG_6);
                float4 _Multiply_9B855117_Out_2;
                Unity_Multiply_float(_Combine_EAF808EA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_9B855117_Out_2);
                float _Multiply_9028821C_Out_2;
                Unity_Multiply_float(_Split_A88C5CBA_B_3, -1, _Multiply_9028821C_Out_2);
                float2 _Vector2_34183E31_Out_0 = float2(_Multiply_9028821C_Out_2, 1);
                float2 _Multiply_25D3DEE7_Out_2;
                Unity_Multiply_float((_Multiply_9B855117_Out_2.xy), _Vector2_34183E31_Out_0, _Multiply_25D3DEE7_Out_2);
                float4 _SampleTexture2D_66E4959F_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_25D3DEE7_Out_2);
                _SampleTexture2D_66E4959F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_66E4959F_RGBA_0);
                float _SampleTexture2D_66E4959F_R_4 = _SampleTexture2D_66E4959F_RGBA_0.r;
                float _SampleTexture2D_66E4959F_G_5 = _SampleTexture2D_66E4959F_RGBA_0.g;
                float _SampleTexture2D_66E4959F_B_6 = _SampleTexture2D_66E4959F_RGBA_0.b;
                float _SampleTexture2D_66E4959F_A_7 = _SampleTexture2D_66E4959F_RGBA_0.a;
                float2 _Vector2_6CC92971_Out_0 = float2(_SampleTexture2D_66E4959F_R_4, _SampleTexture2D_66E4959F_G_5);
                float2 _Multiply_EDE2F02C_Out_2;
                Unity_Multiply_float(_Vector2_6CC92971_Out_0, _Vector2_34183E31_Out_0, _Multiply_EDE2F02C_Out_2);
                float2 _Vector2_6D428360_Out_0 = float2(_Split_CE0AB7C6_R_1, _Split_CE0AB7C6_G_2);
                float2 _Add_6D3412BD_Out_2;
                Unity_Add_float2(_Multiply_EDE2F02C_Out_2, _Vector2_6D428360_Out_0, _Add_6D3412BD_Out_2);
                float _Split_79C8538A_R_1 = _Add_6D3412BD_Out_2[0];
                float _Split_79C8538A_G_2 = _Add_6D3412BD_Out_2[1];
                float _Split_79C8538A_B_3 = 0;
                float _Split_79C8538A_A_4 = 0;
                float _Multiply_576DD59F_Out_2;
                Unity_Multiply_float(_SampleTexture2D_66E4959F_B_6, _Split_CE0AB7C6_B_3, _Multiply_576DD59F_Out_2);
                float3 _Vector3_77AAFCD8_Out_0 = float3(_Split_79C8538A_R_1, _Split_79C8538A_G_2, _Multiply_576DD59F_Out_2);
                float3 _Multiply_9E620CB9_Out_2;
                Unity_Multiply_float(_Vector3_77AAFCD8_Out_0, (_Split_98088E33_B_3.xxx), _Multiply_9E620CB9_Out_2);
                float4 _Combine_D494A8E_RGBA_4;
                float3 _Combine_D494A8E_RGB_5;
                float2 _Combine_D494A8E_RG_6;
                Unity_Combine_float(_Split_34F118DC_B_3, _Split_34F118DC_G_2, 0, 0, _Combine_D494A8E_RGBA_4, _Combine_D494A8E_RGB_5, _Combine_D494A8E_RG_6);
                float4 _Multiply_1B29A9F1_Out_2;
                Unity_Multiply_float(_Combine_D494A8E_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_1B29A9F1_Out_2);
                float2 _Vector2_2EDA3EA2_Out_0 = float2(_Split_A88C5CBA_R_1, 1);
                float2 _Multiply_4083C468_Out_2;
                Unity_Multiply_float((_Multiply_1B29A9F1_Out_2.xy), _Vector2_2EDA3EA2_Out_0, _Multiply_4083C468_Out_2);
                float4 _SampleTexture2D_96366F41_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_4083C468_Out_2);
                _SampleTexture2D_96366F41_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_96366F41_RGBA_0);
                float _SampleTexture2D_96366F41_R_4 = _SampleTexture2D_96366F41_RGBA_0.r;
                float _SampleTexture2D_96366F41_G_5 = _SampleTexture2D_96366F41_RGBA_0.g;
                float _SampleTexture2D_96366F41_B_6 = _SampleTexture2D_96366F41_RGBA_0.b;
                float _SampleTexture2D_96366F41_A_7 = _SampleTexture2D_96366F41_RGBA_0.a;
                float _Multiply_D70B5F94_Out_2;
                Unity_Multiply_float(_SampleTexture2D_96366F41_B_6, _Split_CE0AB7C6_R_1, _Multiply_D70B5F94_Out_2);
                float2 _Vector2_D6F48DBF_Out_0 = float2(_SampleTexture2D_96366F41_R_4, _SampleTexture2D_96366F41_G_5);
                float2 _Multiply_32364D17_Out_2;
                Unity_Multiply_float(_Vector2_D6F48DBF_Out_0, _Vector2_2EDA3EA2_Out_0, _Multiply_32364D17_Out_2);
                float2 _Vector2_5861421E_Out_0 = float2(_Split_CE0AB7C6_B_3, _Split_CE0AB7C6_G_2);
                float2 _Add_15B5B6DC_Out_2;
                Unity_Add_float2(_Multiply_32364D17_Out_2, _Vector2_5861421E_Out_0, _Add_15B5B6DC_Out_2);
                float _Split_68B7323B_R_1 = _Add_15B5B6DC_Out_2[0];
                float _Split_68B7323B_G_2 = _Add_15B5B6DC_Out_2[1];
                float _Split_68B7323B_B_3 = 0;
                float _Split_68B7323B_A_4 = 0;
                float3 _Vector3_1ACBBFC4_Out_0 = float3(_Multiply_D70B5F94_Out_2, _Split_68B7323B_G_2, _Split_68B7323B_R_1);
                float3 _Multiply_1C5CFCC5_Out_2;
                Unity_Multiply_float(_Vector3_1ACBBFC4_Out_0, (_Split_98088E33_R_1.xxx), _Multiply_1C5CFCC5_Out_2);
                float3 _Add_D483B2FD_Out_2;
                Unity_Add_float3(_Multiply_9E620CB9_Out_2, _Multiply_1C5CFCC5_Out_2, _Add_D483B2FD_Out_2);
                float3 _Add_166B5BED_Out_2;
                Unity_Add_float3(_Multiply_B99FFB12_Out_2, _Add_D483B2FD_Out_2, _Add_166B5BED_Out_2);
                float _Add_B73B64F6_Out_2;
                Unity_Add_float(_Split_98088E33_R_1, _Split_98088E33_G_2, _Add_B73B64F6_Out_2);
                float _Add_523B36E8_Out_2;
                Unity_Add_float(_Add_B73B64F6_Out_2, _Split_98088E33_B_3, _Add_523B36E8_Out_2);
                float3 _Divide_86C67C72_Out_2;
                Unity_Divide_float3(_Add_166B5BED_Out_2, (_Add_523B36E8_Out_2.xxx), _Divide_86C67C72_Out_2);
                float3x3 Transform_F679F94B_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_F679F94B_Out_1 = TransformWorldToTangent(_Divide_86C67C72_Out_2.xyz, Transform_F679F94B_tangentTransform_World);
                float3 _Normalize_E5F34A45_Out_1;
                Unity_Normalize_float3(_Transform_F679F94B_Out_1, _Normalize_E5F34A45_Out_1);
                XYZ_1 = (float4(_Normalize_E5F34A45_Out_1, 1.0));
                XZ_2 = (float4(_Vector3_A5ECB01F_Out_0, 1.0));
                YZ_3 = (float4(_Vector3_77AAFCD8_Out_0, 1.0));
                XY_4 = (float4(_Vector3_1ACBBFC4_Out_0, 1.0));
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
            {
                Out = lerp(A, B, T);
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
            
            void Unity_Lerp_float2(float2 A, float2 B, float2 T, out float2 Out)
            {
                Out = lerp(A, B, T);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpacePosition;
                #endif
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_ADEB2ED4;
                float3 _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_ADEB2ED4, _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
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
                float3 Specular;
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
                float4 _Property_9FFBD215_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_DA44CA00_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_B8C9761A;
                _PlanarNM_B8C9761A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_B8C9761A.uv0 = IN.uv0;
                float4 _PlanarNM_B8C9761A_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNM_B8C9761A, _PlanarNM_B8C9761A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_BEF8608F_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_B633DE44_Out_2;
                Unity_Multiply_float(_PlanarNM_B8C9761A_XZ_2, _Property_BEF8608F_Out_0, _Multiply_B633DE44_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_884592D8_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_E65919DE_R_1 = _Property_884592D8_Out_0[0];
                float _Split_E65919DE_G_2 = _Property_884592D8_Out_0[1];
                float _Split_E65919DE_B_3 = _Property_884592D8_Out_0[2];
                float _Split_E65919DE_A_4 = _Property_884592D8_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_CD48789E_Out_0 = float2(_Split_E65919DE_R_1, _Split_E65919DE_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_C408B9B2_Out_0 = float2(_Split_E65919DE_B_3, _Split_E65919DE_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_CEF01838_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_CD48789E_Out_0, _Vector2_C408B9B2_Out_0, _TilingAndOffset_CEF01838_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_5927C7C9_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_CEF01838_Out_3);
                float _SampleTexture2D_5927C7C9_R_4 = _SampleTexture2D_5927C7C9_RGBA_0.r;
                float _SampleTexture2D_5927C7C9_G_5 = _SampleTexture2D_5927C7C9_RGBA_0.g;
                float _SampleTexture2D_5927C7C9_B_6 = _SampleTexture2D_5927C7C9_RGBA_0.b;
                float _SampleTexture2D_5927C7C9_A_7 = _SampleTexture2D_5927C7C9_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_564D6633_Out_2;
                Unity_Multiply_float(_SampleTexture2D_5927C7C9_R_4, 2, _Multiply_564D6633_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_DD5A18F0_Out_2;
                Unity_Add_float(_Multiply_564D6633_Out_2, -1, _Add_DD5A18F0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_ECF8584_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_8D57854C_Out_2;
                Unity_Multiply_float(_Add_DD5A18F0_Out_2, _Property_ECF8584_Out_0, _Multiply_8D57854C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_5C3AA762_Out_1;
                Unity_Saturate_float(_Multiply_8D57854C_Out_2, _Saturate_5C3AA762_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_A0608E3C_Out_1;
                Unity_Absolute_float(_Saturate_5C3AA762_Out_1, _Absolute_A0608E3C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_3A2278B0;
                float3 _BlendOverlayBaseColor_3A2278B0_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_B633DE44_Out_2, _Add_DD5A18F0_Out_2, _Absolute_A0608E3C_Out_1, _BlendOverlayBaseColor_3A2278B0, _BlendOverlayBaseColor_3A2278B0_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3CC54EA6_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Divide_2DD66DF0_Out_2;
                Unity_Divide_float4(float4(1, 1, 0, 0), _Property_3CC54EA6_Out_0, _Divide_2DD66DF0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F6956647_Out_0 = _CoverTriplanarThreshold;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_8999FBDB;
                _TriplanarNM_8999FBDB.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNM_8999FBDB.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNM_8999FBDB_XYZ_1;
                float4 _TriplanarNM_8999FBDB_XZ_2;
                float4 _TriplanarNM_8999FBDB_YZ_3;
                float4 _TriplanarNM_8999FBDB_XY_4;
                SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNM_8999FBDB, _TriplanarNM_8999FBDB_XYZ_1, _TriplanarNM_8999FBDB_XZ_2, _TriplanarNM_8999FBDB_YZ_3, _TriplanarNM_8999FBDB_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_6E2FED81_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_B1CF0578_Out_2;
                Unity_Multiply_float(_TriplanarNM_8999FBDB_XYZ_1, _Property_6E2FED81_Out_0, _Multiply_B1CF0578_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_44AAF8BF_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_3E2881E2_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_44AAF8BF_Out_0.xy));
                float _SampleTexture2D_3E2881E2_R_4 = _SampleTexture2D_3E2881E2_RGBA_0.r;
                float _SampleTexture2D_3E2881E2_G_5 = _SampleTexture2D_3E2881E2_RGBA_0.g;
                float _SampleTexture2D_3E2881E2_B_6 = _SampleTexture2D_3E2881E2_RGBA_0.b;
                float _SampleTexture2D_3E2881E2_A_7 = _SampleTexture2D_3E2881E2_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_3016ED3E_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_5D97A872_Out_2;
                Unity_Multiply_float(_SampleTexture2D_3E2881E2_A_7, _Property_3016ED3E_Out_0, _Multiply_5D97A872_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_1734BFE5_Out_3;
                Unity_Clamp_float(_Multiply_5D97A872_Out_2, 0, 1, _Clamp_1734BFE5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Property_932BDEF_Out_0 = _CoverDirection;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_11AF00D3_Out_0 = float2(_SampleTexture2D_5927C7C9_A_7, _SampleTexture2D_5927C7C9_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Multiply_96CC03D1_Out_2;
                Unity_Multiply_float(_Vector2_11AF00D3_Out_0, float2(2, 2), _Multiply_96CC03D1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_86574D0_Out_2;
                Unity_Add_float2(_Multiply_96CC03D1_Out_2, float2(-1, -1), _Add_86574D0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_B1BD52A_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Multiply_F6F4ED16_Out_2;
                Unity_Multiply_float(_Add_86574D0_Out_2, (_Property_B1BD52A_Out_0.xx), _Multiply_F6F4ED16_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_70B6C51D_R_1 = _Multiply_F6F4ED16_Out_2[0];
                float _Split_70B6C51D_G_2 = _Multiply_F6F4ED16_Out_2[1];
                float _Split_70B6C51D_B_3 = 0;
                float _Split_70B6C51D_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _DotProduct_636FA5B4_Out_2;
                Unity_DotProduct_float2(_Multiply_F6F4ED16_Out_2, _Multiply_F6F4ED16_Out_2, _DotProduct_636FA5B4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_DB4FD3B4_Out_1;
                Unity_Saturate_float(_DotProduct_636FA5B4_Out_2, _Saturate_DB4FD3B4_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_B16221E6_Out_1;
                Unity_OneMinus_float(_Saturate_DB4FD3B4_Out_1, _OneMinus_B16221E6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SquareRoot_E971D74E_Out_1;
                Unity_SquareRoot_float(_OneMinus_B16221E6_Out_1, _SquareRoot_E971D74E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_2B1829A1_Out_0 = float3(_Split_70B6C51D_R_1, _Split_70B6C51D_G_2, _SquareRoot_E971D74E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_C3762513;
                _PlanarNMn_C3762513.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_C3762513.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_C3762513.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_C3762513.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_C3762513.uv0 = IN.uv0;
                float4 _PlanarNMn_C3762513_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNMn_C3762513, _PlanarNMn_C3762513_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_904071D7_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_F54F97E9_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_C3762513_XZ_2.xyz), _Property_904071D7_Out_0, _NormalStrength_F54F97E9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalBlend_2EEFB9AF_Out_2;
                Unity_NormalBlend_float(_Vector3_2B1829A1_Out_0, _NormalStrength_F54F97E9_Out_2, _NormalBlend_2EEFB9AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8D3AA108;
                _TriplanarNMn_8D3AA108.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNMn_8D3AA108.WorldSpaceTangent = IN.WorldSpaceTangent;
                _TriplanarNMn_8D3AA108.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _TriplanarNMn_8D3AA108.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNMn_8D3AA108_XYZ_1;
                float4 _TriplanarNMn_8D3AA108_XZ_2;
                float4 _TriplanarNMn_8D3AA108_YZ_3;
                float4 _TriplanarNMn_8D3AA108_XY_4;
                SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNMn_8D3AA108, _TriplanarNMn_8D3AA108_XYZ_1, _TriplanarNMn_8D3AA108_XZ_2, _TriplanarNMn_8D3AA108_YZ_3, _TriplanarNMn_8D3AA108_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_995C1788_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_44BA1170_Out_2;
                Unity_NormalStrength_float((_TriplanarNMn_8D3AA108_XYZ_1.xyz), _Property_995C1788_Out_0, _NormalStrength_44BA1170_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Multiply_73E49A46_Out_2;
                Unity_Multiply_float(_Property_932BDEF_Out_0, IN.WorldSpaceNormal, _Multiply_73E49A46_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_D1026BB1_R_1 = _Multiply_73E49A46_Out_2[0];
                float _Split_D1026BB1_G_2 = _Multiply_73E49A46_Out_2[1];
                float _Split_D1026BB1_B_3 = _Multiply_73E49A46_Out_2[2];
                float _Split_D1026BB1_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_CCE93C47_Out_2;
                Unity_Add_float(_Split_D1026BB1_R_1, _Split_D1026BB1_G_2, _Add_CCE93C47_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_32345D47_Out_2;
                Unity_Add_float(_Add_CCE93C47_Out_2, _Split_D1026BB1_B_3, _Add_32345D47_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B1FFAD34_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_A2FAE14F_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_4B8044E8_Out_2;
                Unity_Subtract_float(4, _Property_A2FAE14F_Out_0, _Subtract_4B8044E8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_3B4F1D3A_Out_2;
                Unity_Divide_float(_Property_B1FFAD34_Out_0, _Subtract_4B8044E8_Out_2, _Divide_3B4F1D3A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_A4429D68_Out_1;
                Unity_Absolute_float(_Divide_3B4F1D3A_Out_2, _Absolute_A4429D68_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_FB9D1710_Out_2;
                Unity_Power_float(_Absolute_A4429D68_Out_1, _Subtract_4B8044E8_Out_2, _Power_FB9D1710_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_6B3FEC4_Out_3;
                Unity_Clamp_float(_Power_FB9D1710_Out_2, 0, 2, _Clamp_6B3FEC4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_8FBF66FA_Out_2;
                Unity_Multiply_float(_Add_32345D47_Out_2, _Clamp_6B3FEC4_Out_3, _Multiply_8FBF66FA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_9292D876_Out_1;
                Unity_Saturate_float(_Multiply_8FBF66FA_Out_2, _Saturate_9292D876_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_D0BC21C_Out_3;
                Unity_Clamp_float(_Add_32345D47_Out_2, 0, 0.9999, _Clamp_D0BC21C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B34EDBFD_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_B5480478_Out_2;
                Unity_Divide_float(_Property_B34EDBFD_Out_0, 45, _Divide_B5480478_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_CBCAD7A_Out_1;
                Unity_OneMinus_float(_Divide_B5480478_Out_2, _OneMinus_CBCAD7A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_EBEF174D_Out_2;
                Unity_Subtract_float(_Clamp_D0BC21C_Out_3, _OneMinus_CBCAD7A_Out_1, _Subtract_EBEF174D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_AA8A64A3_Out_3;
                Unity_Clamp_float(_Subtract_EBEF174D_Out_2, 0, 2, _Clamp_AA8A64A3_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_BFB32493_Out_2;
                Unity_Divide_float(1, _Divide_B5480478_Out_2, _Divide_BFB32493_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_B62964B9_Out_2;
                Unity_Multiply_float(_Clamp_AA8A64A3_Out_3, _Divide_BFB32493_Out_2, _Multiply_B62964B9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_7B34ADA9_Out_1;
                Unity_Absolute_float(_Multiply_B62964B9_Out_2, _Absolute_7B34ADA9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1DD92663_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_A1FB5EA0_Out_2;
                Unity_Power_float(_Absolute_7B34ADA9_Out_1, _Property_1DD92663_Out_0, _Power_A1FB5EA0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_C4852D4_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1AFBC8B2_Out_1;
                Unity_OneMinus_float(_Property_C4852D4_Out_0, _OneMinus_1AFBC8B2_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_DC11AC84_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_DC11AC84_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_DC11AC84_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_DC11AC84_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_86148D72_Out_2;
                Unity_Add_float(_OneMinus_1AFBC8B2_Out_1, _Split_DC11AC84_G_2, _Add_86148D72_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_39BC5217_Out_2;
                Unity_Add_float(_Add_86148D72_Out_2, 1, _Add_39BC5217_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_97F72B5E_Out_3;
                Unity_Clamp_float(_Add_39BC5217_Out_2, 0, 1, _Clamp_97F72B5E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_28703D9B_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_38B3D359_Out_2;
                Unity_Add_float(_Add_86148D72_Out_2, _Property_28703D9B_Out_0, _Add_38B3D359_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_407B44D8_Out_2;
                Unity_Divide_float(_Add_38B3D359_Out_2, _Add_86148D72_Out_2, _Divide_407B44D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_789A0D0E_Out_1;
                Unity_OneMinus_float(_Divide_407B44D8_Out_2, _OneMinus_789A0D0E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_7428640F_Out_2;
                Unity_Add_float(_OneMinus_789A0D0E_Out_1, -0.5, _Add_7428640F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_9C76860B_Out_3;
                Unity_Clamp_float(_Add_7428640F_Out_2, 0, 1, _Clamp_9C76860B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F1ED053D_Out_2;
                Unity_Add_float(_Clamp_97F72B5E_Out_3, _Clamp_9C76860B_Out_3, _Add_F1ED053D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_BFC65370_Out_3;
                Unity_Clamp_float(_Add_F1ED053D_Out_2, 0, 1, _Clamp_BFC65370_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_180E431B_Out_2;
                Unity_Multiply_float(_Power_A1FB5EA0_Out_2, _Clamp_BFC65370_Out_3, _Multiply_180E431B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_C26F02DA_Out_2;
                Unity_Multiply_float(_Saturate_9292D876_Out_1, _Multiply_180E431B_Out_2, _Multiply_C26F02DA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_3522A454_Out_3;
                Unity_Lerp_float3(_NormalBlend_2EEFB9AF_Out_2, _NormalStrength_44BA1170_Out_2, (_Multiply_C26F02DA_Out_2.xxx), _Lerp_3522A454_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_14C81C91_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_14C81C91_Out_1 = normalize(mul(Transform_14C81C91_transposeTangent, _Lerp_3522A454_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Multiply_1B01DF43_Out_2;
                Unity_Multiply_float(_Property_932BDEF_Out_0, _Transform_14C81C91_Out_1, _Multiply_1B01DF43_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_A0DF36AC_R_1 = _Multiply_1B01DF43_Out_2[0];
                float _Split_A0DF36AC_G_2 = _Multiply_1B01DF43_Out_2[1];
                float _Split_A0DF36AC_B_3 = _Multiply_1B01DF43_Out_2[2];
                float _Split_A0DF36AC_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_CDFDCB4A_Out_2;
                Unity_Add_float(_Split_A0DF36AC_R_1, _Split_A0DF36AC_G_2, _Add_CDFDCB4A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D6F78AB0_Out_2;
                Unity_Add_float(_Add_CDFDCB4A_Out_2, _Split_A0DF36AC_B_3, _Add_D6F78AB0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_955E55F1_Out_2;
                Unity_Multiply_float(_Add_D6F78AB0_Out_2, _Clamp_6B3FEC4_Out_3, _Multiply_955E55F1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2AF9B3D_Out_2;
                Unity_Multiply_float(_Clamp_6B3FEC4_Out_3, _Property_1DD92663_Out_0, _Multiply_2AF9B3D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F6BB913B_Out_2;
                Unity_Multiply_float(_Multiply_2AF9B3D_Out_2, _Multiply_180E431B_Out_2, _Multiply_F6BB913B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2FBE96C8_Out_2;
                Unity_Multiply_float(_Multiply_955E55F1_Out_2, _Multiply_F6BB913B_Out_2, _Multiply_2FBE96C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_4DA318C7;
                _TriplanarNM_4DA318C7.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNM_4DA318C7.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNM_4DA318C7_XYZ_1;
                float4 _TriplanarNM_4DA318C7_XZ_2;
                float4 _TriplanarNM_4DA318C7_YZ_3;
                float4 _TriplanarNM_4DA318C7_XY_4;
                SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNM_4DA318C7, _TriplanarNM_4DA318C7_XYZ_1, _TriplanarNM_4DA318C7_XZ_2, _TriplanarNM_4DA318C7_YZ_3, _TriplanarNM_4DA318C7_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_886A1366_R_1 = _TriplanarNM_4DA318C7_XYZ_1[0];
                float _Split_886A1366_G_2 = _TriplanarNM_4DA318C7_XYZ_1[1];
                float _Split_886A1366_B_3 = _TriplanarNM_4DA318C7_XYZ_1[2];
                float _Split_886A1366_A_4 = _TriplanarNM_4DA318C7_XYZ_1[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9F3C748A_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_38F71BFB_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_E157D4E8_Out_0 = float2(_Property_9F3C748A_Out_0, _Property_38F71BFB_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_514307DE_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_42D344B7_Out_2;
                Unity_Add_float2(_Vector2_E157D4E8_Out_0, (_Property_514307DE_Out_0.xx), _Add_42D344B7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_BD5FD283_Out_3;
                Unity_Remap_float(_Split_886A1366_B_3, float2 (0, 1), _Add_42D344B7_Out_2, _Remap_BD5FD283_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_AA9F17C9_Out_2;
                Unity_Multiply_float(_Multiply_2FBE96C8_Out_2, _Remap_BD5FD283_Out_3, _Multiply_AA9F17C9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_B5BA182F_R_1 = IN.VertexColor[0];
                float _Split_B5BA182F_G_2 = IN.VertexColor[1];
                float _Split_B5BA182F_B_3 = IN.VertexColor[2];
                float _Split_B5BA182F_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_17BF6B0_Out_2;
                Unity_Multiply_float(_Multiply_AA9F17C9_Out_2, _Split_B5BA182F_G_2, _Multiply_17BF6B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_E4AE5990_Out_1;
                Unity_Saturate_float(_Multiply_17BF6B0_Out_2, _Saturate_E4AE5990_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_80D50DF7_Out_2;
                Unity_Multiply_float(_Clamp_1734BFE5_Out_3, _Saturate_E4AE5990_Out_1, _Multiply_80D50DF7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_D675BDBA_Out_0 = _Multiply_80D50DF7_Out_2;
                #else
                float _UseDynamicCoverTStaticMaskF_D675BDBA_Out_0 = _Clamp_1734BFE5_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_62655FB2_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_3A2278B0_OutVector4_1, (_Multiply_B1CF0578_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_D675BDBA_Out_0.xxx), _Lerp_62655FB2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_9F64AEAF_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_4AEEE38_Out_2;
                Unity_Multiply_float((_Property_9F64AEAF_Out_0.xyz), _Lerp_62655FB2_Out_3, _Multiply_4AEEE38_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_1558D782_Out_1;
                Unity_OneMinus_float(_Split_B5BA182F_R_1, _OneMinus_1558D782_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_70281627_Out_3;
                Unity_Lerp_float3(_Lerp_62655FB2_Out_3, _Multiply_4AEEE38_Out_2, (_OneMinus_1558D782_Out_1.xxx), _Lerp_70281627_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_9A9B62BA_Out_0 = _CoverNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_C63EEF20_Out_2;
                Unity_NormalStrength_float((_TriplanarNMn_8D3AA108_XYZ_1.xyz), _Property_9A9B62BA_Out_0, _NormalStrength_C63EEF20_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_C4AF3FE9_Out_3;
                Unity_Lerp_float3(_NormalBlend_2EEFB9AF_Out_2, _NormalStrength_C63EEF20_Out_2, (_UseDynamicCoverTStaticMaskF_D675BDBA_Out_0.xxx), _Lerp_C4AF3FE9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_37584E90;
                _PlanarNM_37584E90.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_37584E90.uv0 = IN.uv0;
                float4 _PlanarNM_37584E90_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_SpecularColorMap, sampler_SpecularColorMap), _SpecularColorMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNM_37584E90, _PlanarNM_37584E90_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_990E8D49_Out_0 = _SpecularColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_B748F7A3_Out_2;
                Unity_Multiply_float(_PlanarNM_37584E90_XZ_2, _Property_990E8D49_Out_0, _Multiply_B748F7A3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_B6E41595;
                _TriplanarNM_B6E41595.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNM_B6E41595.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNM_B6E41595_XYZ_1;
                float4 _TriplanarNM_B6E41595_XZ_2;
                float4 _TriplanarNM_B6E41595_YZ_3;
                float4 _TriplanarNM_B6E41595_XY_4;
                SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_CoverSpecularColorMap, sampler_CoverSpecularColorMap), _CoverSpecularColorMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNM_B6E41595, _TriplanarNM_B6E41595_XYZ_1, _TriplanarNM_B6E41595_XZ_2, _TriplanarNM_B6E41595_YZ_3, _TriplanarNM_B6E41595_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_509C8943_Out_0 = _CoverSpecularColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_21AEB05A_Out_2;
                Unity_Multiply_float(_TriplanarNM_B6E41595_XYZ_1, _Property_509C8943_Out_0, _Multiply_21AEB05A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Lerp_492C1475_Out_3;
                Unity_Lerp_float4(_Multiply_B748F7A3_Out_2, _Multiply_21AEB05A_Out_2, (_UseDynamicCoverTStaticMaskF_D675BDBA_Out_0.xxxx), _Lerp_492C1475_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_CD10AA9;
                _PlanarNM_CD10AA9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_CD10AA9.uv0 = IN.uv0;
                float4 _PlanarNM_CD10AA9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNM_CD10AA9, _PlanarNM_CD10AA9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_7D02D1FB_R_1 = _PlanarNM_CD10AA9_XZ_2[0];
                float _Split_7D02D1FB_G_2 = _PlanarNM_CD10AA9_XZ_2[1];
                float _Split_7D02D1FB_B_3 = _PlanarNM_CD10AA9_XZ_2[2];
                float _Split_7D02D1FB_A_4 = _PlanarNM_CD10AA9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_7909333C_Out_0 = _BaseAORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_74453F1_Out_0 = _BaseAORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_ECA2BD5D_Out_0 = float2(_Property_7909333C_Out_0, _Property_74453F1_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_AEC90A01_Out_3;
                Unity_Remap_float(_Split_7D02D1FB_G_2, float2 (0, 1), _Vector2_ECA2BD5D_Out_0, _Remap_AEC90A01_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EB51FFDB_Out_0 = _BaseSmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_90685DB9_Out_0 = _BaseSmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_DCB6D95B_Out_0 = float2(_Property_EB51FFDB_Out_0, _Property_90685DB9_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_BCBD1203_Out_3;
                Unity_Remap_float(_Split_7D02D1FB_A_4, float2 (0, 1), _Vector2_DCB6D95B_Out_0, _Remap_BCBD1203_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_FCB115F_Out_2;
                Unity_Multiply_float(_SampleTexture2D_5927C7C9_B_6, 2, _Multiply_FCB115F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_7A0B27DA_Out_2;
                Unity_Add_float(_Multiply_FCB115F_Out_2, -1, _Add_7A0B27DA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_743C6FDF_Out_0 = _DetailSmoothnessScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_EF297CC5_Out_2;
                Unity_Multiply_float(_Add_7A0B27DA_Out_2, _Property_743C6FDF_Out_0, _Multiply_EF297CC5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_9D047AFE_Out_1;
                Unity_Saturate_float(_Multiply_EF297CC5_Out_2, _Saturate_9D047AFE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_5EDAB6F1_Out_1;
                Unity_Absolute_float(_Saturate_9D047AFE_Out_1, _Absolute_5EDAB6F1_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a _BlendOverlayDetailSmoothness_F1E49D89;
                float _BlendOverlayDetailSmoothness_F1E49D89_SmoothnessOverlay_1;
                SG_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a(_Remap_BCBD1203_Out_3, _Add_7A0B27DA_Out_2, _Absolute_5EDAB6F1_Out_1, _BlendOverlayDetailSmoothness_F1E49D89, _BlendOverlayDetailSmoothness_F1E49D89_SmoothnessOverlay_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_888C236C_Out_1;
                Unity_Saturate_float(_BlendOverlayDetailSmoothness_F1E49D89_SmoothnessOverlay_1, _Saturate_888C236C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_19E66B27_Out_0 = float2(_Remap_AEC90A01_Out_3, _Saturate_888C236C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_7D2FE994_Out_0 = _CoverAORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_D92A3C0D_Out_0 = _CoverAORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_56FEC5A6_Out_0 = float2(_Property_7D2FE994_Out_0, _Property_D92A3C0D_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_814422D8_Out_3;
                Unity_Remap_float(_Split_886A1366_G_2, float2 (0, 1), _Vector2_56FEC5A6_Out_0, _Remap_814422D8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F5AD7AE4_Out_0 = _CoverSmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C64A96FA_Out_0 = _CoverSmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_B3FF1CAA_Out_0 = float2(_Property_F5AD7AE4_Out_0, _Property_C64A96FA_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_CC963183_Out_3;
                Unity_Remap_float(_Split_886A1366_A_4, float2 (0, 1), _Vector2_B3FF1CAA_Out_0, _Remap_CC963183_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_7F2662FA_Out_0 = float2(_Remap_814422D8_Out_3, _Remap_CC963183_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Lerp_1C480CF8_Out_3;
                Unity_Lerp_float2(_Vector2_19E66B27_Out_0, _Vector2_7F2662FA_Out_0, (_UseDynamicCoverTStaticMaskF_D675BDBA_Out_0.xx), _Lerp_1C480CF8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_8A3D9E6A_R_1 = _Lerp_1C480CF8_Out_3[0];
                float _Split_8A3D9E6A_G_2 = _Lerp_1C480CF8_Out_3[1];
                float _Split_8A3D9E6A_B_3 = 0;
                float _Split_8A3D9E6A_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6F35123F_Out_0 = _WetSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_9CB130A8_Out_3;
                Unity_Lerp_float(_Split_8A3D9E6A_G_2, _Property_6F35123F_Out_0, _OneMinus_1558D782_Out_1, _Lerp_9CB130A8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A449C527_R_1 = _PlanarNM_B8C9761A_XZ_2[0];
                float _Split_A449C527_G_2 = _PlanarNM_B8C9761A_XZ_2[1];
                float _Split_A449C527_B_3 = _PlanarNM_B8C9761A_XZ_2[2];
                float _Split_A449C527_A_4 = _PlanarNM_B8C9761A_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EDD4395E_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_70281627_Out_3;
                surface.Normal = _Lerp_C4AF3FE9_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Specular = (_Lerp_492C1475_Out_3.xyz);
                surface.Smoothness = _Lerp_9CB130A8_Out_3;
                surface.Occlusion = _Split_8A3D9E6A_R_1;
                surface.Alpha = _Split_A449C527_A_4;
                surface.AlphaClipThreshold = _Property_EDD4395E_Out_0;
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
                float4 positionCS : SV_POSITION;
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
                float3 interp05 : TEXCOORD5;
                float2 interp06 : TEXCOORD6;
                float3 interp07 : TEXCOORD7;
                float4 interp08 : TEXCOORD8;
                float4 interp09 : TEXCOORD9;
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
                output.interp04.xyzw = input.color;
                output.interp05.xyz = input.viewDirectionWS;
                #if defined(LIGHTMAP_ON)
                output.interp06.xy = input.lightmapUV;
                #endif
                #if !defined(LIGHTMAP_ON)
                output.interp07.xyz = input.sh;
                #endif
                output.interp08.xyzw = input.fogFactorAndVertexLight;
                output.interp09.xyzw = input.shadowCoord;
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
                output.color = input.interp04.xyzw;
                output.viewDirectionWS = input.interp05.xyz;
                #if defined(LIGHTMAP_ON)
                output.lightmapUV = input.interp06.xy;
                #endif
                #if !defined(LIGHTMAP_ON)
                output.sh = input.interp07.xyz;
                #endif
                output.fogFactorAndVertexLight = input.interp08.xyzw;
                output.shadowCoord = input.interp09.xyzw;
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
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceNormal =           input.normalOS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceTangent =          input.tangentOS;
            #endif
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpacePosition =         input.positionOS;
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // use bitangent on the fly like in hdrp
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // This is explained in section 2.2 in "surface gradient based bump mapping framework"
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceBiTangent =         renormFactor*bitang;
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
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
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
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        
        
        
        
        
        
        
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_SHADOWCASTER
        
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
            float _AlphaCutoff;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float4 _SpecularColor;
            float _BaseNormalScale;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float3 _CoverDirection;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverTriplanarThreshold;
            float4 _CoverSpecularColor;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
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
            TEXTURE2D(_SpecularColorMap); SAMPLER(sampler_SpecularColorMap); float4 _SpecularColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverSpecularColorMap); SAMPLER(sampler_CoverSpecularColorMap); float4 _CoverSpecularColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // c7f63929085c93b4f2216b914e6e81d6
            #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
            {
            };
            
            void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
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
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpacePosition;
                #endif
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_ADEB2ED4;
                float3 _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_ADEB2ED4, _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 AbsoluteWorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_9FFBD215_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_DA44CA00_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_B8C9761A;
                _PlanarNM_B8C9761A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_B8C9761A.uv0 = IN.uv0;
                float4 _PlanarNM_B8C9761A_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNM_B8C9761A, _PlanarNM_B8C9761A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A449C527_R_1 = _PlanarNM_B8C9761A_XZ_2[0];
                float _Split_A449C527_G_2 = _PlanarNM_B8C9761A_XZ_2[1];
                float _Split_A449C527_B_3 = _PlanarNM_B8C9761A_XZ_2[2];
                float _Split_A449C527_A_4 = _PlanarNM_B8C9761A_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EDD4395E_Out_0 = _AlphaCutoff;
                #endif
                surface.Alpha = _Split_A449C527_A_4;
                surface.AlphaClipThreshold = _Property_EDD4395E_Out_0;
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
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
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
                output.interp01.xyzw = input.texCoord0;
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
                output.texCoord0 = input.interp01.xyzw;
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
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceNormal =           input.normalOS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceTangent =          input.tangentOS;
            #endif
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpacePosition =         input.positionOS;
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
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
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
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
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        
        
        
        
        
        
        
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_DEPTHONLY
        
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
            float _AlphaCutoff;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float4 _SpecularColor;
            float _BaseNormalScale;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float3 _CoverDirection;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverTriplanarThreshold;
            float4 _CoverSpecularColor;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
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
            TEXTURE2D(_SpecularColorMap); SAMPLER(sampler_SpecularColorMap); float4 _SpecularColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverSpecularColorMap); SAMPLER(sampler_CoverSpecularColorMap); float4 _CoverSpecularColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // c7f63929085c93b4f2216b914e6e81d6
            #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
            {
            };
            
            void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
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
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpacePosition;
                #endif
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_ADEB2ED4;
                float3 _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_ADEB2ED4, _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 AbsoluteWorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
            };
            
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_9FFBD215_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_DA44CA00_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_B8C9761A;
                _PlanarNM_B8C9761A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_B8C9761A.uv0 = IN.uv0;
                float4 _PlanarNM_B8C9761A_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNM_B8C9761A, _PlanarNM_B8C9761A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A449C527_R_1 = _PlanarNM_B8C9761A_XZ_2[0];
                float _Split_A449C527_G_2 = _PlanarNM_B8C9761A_XZ_2[1];
                float _Split_A449C527_B_3 = _PlanarNM_B8C9761A_XZ_2[2];
                float _Split_A449C527_A_4 = _PlanarNM_B8C9761A_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EDD4395E_Out_0 = _AlphaCutoff;
                #endif
                surface.Alpha = _Split_A449C527_A_4;
                surface.AlphaClipThreshold = _Property_EDD4395E_Out_0;
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
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
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
                output.interp01.xyzw = input.texCoord0;
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
                output.texCoord0 = input.interp01.xyzw;
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
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceNormal =           input.normalOS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceTangent =          input.tangentOS;
            #endif
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpacePosition =         input.positionOS;
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.AbsoluteWorldSpacePosition =  GetAbsolutePositionWS(input.positionWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
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
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
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
        
        #if defined(KEYWORD_PERMUTATION_0)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        
        
        
        
        
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_META
        
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
            float _AlphaCutoff;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float4 _SpecularColor;
            float _BaseNormalScale;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float3 _CoverDirection;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverTriplanarThreshold;
            float4 _CoverSpecularColor;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
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
            TEXTURE2D(_SpecularColorMap); SAMPLER(sampler_SpecularColorMap); float4 _SpecularColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverSpecularColorMap); SAMPLER(sampler_CoverSpecularColorMap); float4 _CoverSpecularColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_5927C7C9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_66E4959F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_96366F41_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_3E2881E2_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // c7f63929085c93b4f2216b914e6e81d6
            #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
            {
            };
            
            void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
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
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
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
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
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
            
            void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A / B;
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Absolute_float3(float3 In, out float3 Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float3(float3 A, float3 B, out float3 Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A + B;
            }
            
            struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
            {
                float3 WorldSpaceNormal;
                float3 AbsoluteWorldSpacePosition;
            };
            
            void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
            {
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float _Property_7A4DC59B_Out_0 = Vector1_41461AC9;
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_D99671F1_Out_2);
                float3 _Sign_C0850857_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_C0850857_Out_1);
                float _Split_EEBC69B5_R_1 = _Sign_C0850857_Out_1[0];
                float _Split_EEBC69B5_G_2 = _Sign_C0850857_Out_1[1];
                float _Split_EEBC69B5_B_3 = _Sign_C0850857_Out_1[2];
                float _Split_EEBC69B5_A_4 = 0;
                float2 _Vector2_7598EA98_Out_0 = float2(_Split_EEBC69B5_G_2, 1);
                float2 _Multiply_F82F3FE2_Out_2;
                Unity_Multiply_float((_Multiply_D99671F1_Out_2.xy), _Vector2_7598EA98_Out_0, _Multiply_F82F3FE2_Out_2);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_F82F3FE2_Out_2);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float3 _Absolute_FF95EDEB_Out_1;
                Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_FF95EDEB_Out_1);
                float _Property_F8688E0_Out_0 = Vector1_E4D1C13A;
                float3 _Power_C741CD3A_Out_2;
                Unity_Power_float3(_Absolute_FF95EDEB_Out_1, (_Property_F8688E0_Out_0.xxx), _Power_C741CD3A_Out_2);
                float3 _Multiply_3FB4A346_Out_2;
                Unity_Multiply_float(_Power_C741CD3A_Out_2, _Power_C741CD3A_Out_2, _Multiply_3FB4A346_Out_2);
                float _Split_98088E33_R_1 = _Multiply_3FB4A346_Out_2[0];
                float _Split_98088E33_G_2 = _Multiply_3FB4A346_Out_2[1];
                float _Split_98088E33_B_3 = _Multiply_3FB4A346_Out_2[2];
                float _Split_98088E33_A_4 = 0;
                float4 _Multiply_B99FFB12_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_RGBA_0, (_Split_98088E33_G_2.xxxx), _Multiply_B99FFB12_Out_2);
                float4 _Combine_EAF808EA_RGBA_4;
                float3 _Combine_EAF808EA_RGB_5;
                float2 _Combine_EAF808EA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_G_2, 0, 0, _Combine_EAF808EA_RGBA_4, _Combine_EAF808EA_RGB_5, _Combine_EAF808EA_RG_6);
                float4 _Multiply_9B855117_Out_2;
                Unity_Multiply_float(_Combine_EAF808EA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_9B855117_Out_2);
                float _Multiply_B8AC16FB_Out_2;
                Unity_Multiply_float(_Split_EEBC69B5_B_3, -1, _Multiply_B8AC16FB_Out_2);
                float2 _Vector2_F031282A_Out_0 = float2(_Multiply_B8AC16FB_Out_2, 1);
                float2 _Multiply_89A39D70_Out_2;
                Unity_Multiply_float((_Multiply_9B855117_Out_2.xy), _Vector2_F031282A_Out_0, _Multiply_89A39D70_Out_2);
                float4 _SampleTexture2D_66E4959F_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_89A39D70_Out_2);
                float _SampleTexture2D_66E4959F_R_4 = _SampleTexture2D_66E4959F_RGBA_0.r;
                float _SampleTexture2D_66E4959F_G_5 = _SampleTexture2D_66E4959F_RGBA_0.g;
                float _SampleTexture2D_66E4959F_B_6 = _SampleTexture2D_66E4959F_RGBA_0.b;
                float _SampleTexture2D_66E4959F_A_7 = _SampleTexture2D_66E4959F_RGBA_0.a;
                float4 _Multiply_9E620CB9_Out_2;
                Unity_Multiply_float(_SampleTexture2D_66E4959F_RGBA_0, (_Split_98088E33_B_3.xxxx), _Multiply_9E620CB9_Out_2);
                float4 _Combine_D494A8E_RGBA_4;
                float3 _Combine_D494A8E_RGB_5;
                float2 _Combine_D494A8E_RG_6;
                Unity_Combine_float(_Split_34F118DC_B_3, _Split_34F118DC_G_2, 0, 0, _Combine_D494A8E_RGBA_4, _Combine_D494A8E_RGB_5, _Combine_D494A8E_RG_6);
                float4 _Multiply_1B29A9F1_Out_2;
                Unity_Multiply_float(_Combine_D494A8E_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_1B29A9F1_Out_2);
                float2 _Vector2_1F147BEC_Out_0 = float2(_Split_EEBC69B5_R_1, 1);
                float2 _Multiply_5B8B54E9_Out_2;
                Unity_Multiply_float((_Multiply_1B29A9F1_Out_2.xy), _Vector2_1F147BEC_Out_0, _Multiply_5B8B54E9_Out_2);
                float4 _SampleTexture2D_96366F41_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5B8B54E9_Out_2);
                float _SampleTexture2D_96366F41_R_4 = _SampleTexture2D_96366F41_RGBA_0.r;
                float _SampleTexture2D_96366F41_G_5 = _SampleTexture2D_96366F41_RGBA_0.g;
                float _SampleTexture2D_96366F41_B_6 = _SampleTexture2D_96366F41_RGBA_0.b;
                float _SampleTexture2D_96366F41_A_7 = _SampleTexture2D_96366F41_RGBA_0.a;
                float4 _Multiply_1C5CFCC5_Out_2;
                Unity_Multiply_float(_SampleTexture2D_96366F41_RGBA_0, (_Split_98088E33_R_1.xxxx), _Multiply_1C5CFCC5_Out_2);
                float4 _Add_D483B2FD_Out_2;
                Unity_Add_float4(_Multiply_9E620CB9_Out_2, _Multiply_1C5CFCC5_Out_2, _Add_D483B2FD_Out_2);
                float4 _Add_166B5BED_Out_2;
                Unity_Add_float4(_Multiply_B99FFB12_Out_2, _Add_D483B2FD_Out_2, _Add_166B5BED_Out_2);
                float _Add_B73B64F6_Out_2;
                Unity_Add_float(_Split_98088E33_R_1, _Split_98088E33_G_2, _Add_B73B64F6_Out_2);
                float _Add_523B36E8_Out_2;
                Unity_Add_float(_Add_B73B64F6_Out_2, _Split_98088E33_B_3, _Add_523B36E8_Out_2);
                float4 _Divide_86C67C72_Out_2;
                Unity_Divide_float4(_Add_166B5BED_Out_2, (_Add_523B36E8_Out_2.xxxx), _Divide_86C67C72_Out_2);
                XYZ_1 = _Divide_86C67C72_Out_2;
                XZ_2 = _SampleTexture2D_AF934D9A_RGBA_0;
                YZ_3 = _SampleTexture2D_66E4959F_RGBA_0;
                XY_4 = _SampleTexture2D_96366F41_RGBA_0;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
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
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A / B;
            }
            
            struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 AbsoluteWorldSpacePosition;
            };
            
            void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
            {
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float _Property_7A4DC59B_Out_0 = Vector1_41461AC9;
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_D99671F1_Out_2);
                float3 _Sign_937BD7C4_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_937BD7C4_Out_1);
                float _Split_A88C5CBA_R_1 = _Sign_937BD7C4_Out_1[0];
                float _Split_A88C5CBA_G_2 = _Sign_937BD7C4_Out_1[1];
                float _Split_A88C5CBA_B_3 = _Sign_937BD7C4_Out_1[2];
                float _Split_A88C5CBA_A_4 = 0;
                float2 _Vector2_DC7A07A_Out_0 = float2(_Split_A88C5CBA_G_2, 1);
                float2 _Multiply_6E58BF97_Out_2;
                Unity_Multiply_float((_Multiply_D99671F1_Out_2.xy), _Vector2_DC7A07A_Out_0, _Multiply_6E58BF97_Out_2);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_6E58BF97_Out_2);
                _SampleTexture2D_AF934D9A_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AF934D9A_RGBA_0);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float2 _Vector2_699A5DA1_Out_0 = float2(_SampleTexture2D_AF934D9A_R_4, _SampleTexture2D_AF934D9A_G_5);
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
                float _Multiply_97283B7E_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_B_6, _Split_CE0AB7C6_G_2, _Multiply_97283B7E_Out_2);
                float3 _Vector3_A5ECB01F_Out_0 = float3(_Split_1D7F6EE9_R_1, _Multiply_97283B7E_Out_2, _Split_1D7F6EE9_G_2);
                float3 _Absolute_FF95EDEB_Out_1;
                Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_FF95EDEB_Out_1);
                float _Property_F8688E0_Out_0 = Vector1_E4D1C13A;
                float3 _Power_C741CD3A_Out_2;
                Unity_Power_float3(_Absolute_FF95EDEB_Out_1, (_Property_F8688E0_Out_0.xxx), _Power_C741CD3A_Out_2);
                float3 _Multiply_3FB4A346_Out_2;
                Unity_Multiply_float(_Power_C741CD3A_Out_2, _Power_C741CD3A_Out_2, _Multiply_3FB4A346_Out_2);
                float _Split_98088E33_R_1 = _Multiply_3FB4A346_Out_2[0];
                float _Split_98088E33_G_2 = _Multiply_3FB4A346_Out_2[1];
                float _Split_98088E33_B_3 = _Multiply_3FB4A346_Out_2[2];
                float _Split_98088E33_A_4 = 0;
                float3 _Multiply_B99FFB12_Out_2;
                Unity_Multiply_float(_Vector3_A5ECB01F_Out_0, (_Split_98088E33_G_2.xxx), _Multiply_B99FFB12_Out_2);
                float4 _Combine_EAF808EA_RGBA_4;
                float3 _Combine_EAF808EA_RGB_5;
                float2 _Combine_EAF808EA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_G_2, 0, 0, _Combine_EAF808EA_RGBA_4, _Combine_EAF808EA_RGB_5, _Combine_EAF808EA_RG_6);
                float4 _Multiply_9B855117_Out_2;
                Unity_Multiply_float(_Combine_EAF808EA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_9B855117_Out_2);
                float _Multiply_9028821C_Out_2;
                Unity_Multiply_float(_Split_A88C5CBA_B_3, -1, _Multiply_9028821C_Out_2);
                float2 _Vector2_34183E31_Out_0 = float2(_Multiply_9028821C_Out_2, 1);
                float2 _Multiply_25D3DEE7_Out_2;
                Unity_Multiply_float((_Multiply_9B855117_Out_2.xy), _Vector2_34183E31_Out_0, _Multiply_25D3DEE7_Out_2);
                float4 _SampleTexture2D_66E4959F_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_25D3DEE7_Out_2);
                _SampleTexture2D_66E4959F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_66E4959F_RGBA_0);
                float _SampleTexture2D_66E4959F_R_4 = _SampleTexture2D_66E4959F_RGBA_0.r;
                float _SampleTexture2D_66E4959F_G_5 = _SampleTexture2D_66E4959F_RGBA_0.g;
                float _SampleTexture2D_66E4959F_B_6 = _SampleTexture2D_66E4959F_RGBA_0.b;
                float _SampleTexture2D_66E4959F_A_7 = _SampleTexture2D_66E4959F_RGBA_0.a;
                float2 _Vector2_6CC92971_Out_0 = float2(_SampleTexture2D_66E4959F_R_4, _SampleTexture2D_66E4959F_G_5);
                float2 _Multiply_EDE2F02C_Out_2;
                Unity_Multiply_float(_Vector2_6CC92971_Out_0, _Vector2_34183E31_Out_0, _Multiply_EDE2F02C_Out_2);
                float2 _Vector2_6D428360_Out_0 = float2(_Split_CE0AB7C6_R_1, _Split_CE0AB7C6_G_2);
                float2 _Add_6D3412BD_Out_2;
                Unity_Add_float2(_Multiply_EDE2F02C_Out_2, _Vector2_6D428360_Out_0, _Add_6D3412BD_Out_2);
                float _Split_79C8538A_R_1 = _Add_6D3412BD_Out_2[0];
                float _Split_79C8538A_G_2 = _Add_6D3412BD_Out_2[1];
                float _Split_79C8538A_B_3 = 0;
                float _Split_79C8538A_A_4 = 0;
                float _Multiply_576DD59F_Out_2;
                Unity_Multiply_float(_SampleTexture2D_66E4959F_B_6, _Split_CE0AB7C6_B_3, _Multiply_576DD59F_Out_2);
                float3 _Vector3_77AAFCD8_Out_0 = float3(_Split_79C8538A_R_1, _Split_79C8538A_G_2, _Multiply_576DD59F_Out_2);
                float3 _Multiply_9E620CB9_Out_2;
                Unity_Multiply_float(_Vector3_77AAFCD8_Out_0, (_Split_98088E33_B_3.xxx), _Multiply_9E620CB9_Out_2);
                float4 _Combine_D494A8E_RGBA_4;
                float3 _Combine_D494A8E_RGB_5;
                float2 _Combine_D494A8E_RG_6;
                Unity_Combine_float(_Split_34F118DC_B_3, _Split_34F118DC_G_2, 0, 0, _Combine_D494A8E_RGBA_4, _Combine_D494A8E_RGB_5, _Combine_D494A8E_RG_6);
                float4 _Multiply_1B29A9F1_Out_2;
                Unity_Multiply_float(_Combine_D494A8E_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_1B29A9F1_Out_2);
                float2 _Vector2_2EDA3EA2_Out_0 = float2(_Split_A88C5CBA_R_1, 1);
                float2 _Multiply_4083C468_Out_2;
                Unity_Multiply_float((_Multiply_1B29A9F1_Out_2.xy), _Vector2_2EDA3EA2_Out_0, _Multiply_4083C468_Out_2);
                float4 _SampleTexture2D_96366F41_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_4083C468_Out_2);
                _SampleTexture2D_96366F41_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_96366F41_RGBA_0);
                float _SampleTexture2D_96366F41_R_4 = _SampleTexture2D_96366F41_RGBA_0.r;
                float _SampleTexture2D_96366F41_G_5 = _SampleTexture2D_96366F41_RGBA_0.g;
                float _SampleTexture2D_96366F41_B_6 = _SampleTexture2D_96366F41_RGBA_0.b;
                float _SampleTexture2D_96366F41_A_7 = _SampleTexture2D_96366F41_RGBA_0.a;
                float _Multiply_D70B5F94_Out_2;
                Unity_Multiply_float(_SampleTexture2D_96366F41_B_6, _Split_CE0AB7C6_R_1, _Multiply_D70B5F94_Out_2);
                float2 _Vector2_D6F48DBF_Out_0 = float2(_SampleTexture2D_96366F41_R_4, _SampleTexture2D_96366F41_G_5);
                float2 _Multiply_32364D17_Out_2;
                Unity_Multiply_float(_Vector2_D6F48DBF_Out_0, _Vector2_2EDA3EA2_Out_0, _Multiply_32364D17_Out_2);
                float2 _Vector2_5861421E_Out_0 = float2(_Split_CE0AB7C6_B_3, _Split_CE0AB7C6_G_2);
                float2 _Add_15B5B6DC_Out_2;
                Unity_Add_float2(_Multiply_32364D17_Out_2, _Vector2_5861421E_Out_0, _Add_15B5B6DC_Out_2);
                float _Split_68B7323B_R_1 = _Add_15B5B6DC_Out_2[0];
                float _Split_68B7323B_G_2 = _Add_15B5B6DC_Out_2[1];
                float _Split_68B7323B_B_3 = 0;
                float _Split_68B7323B_A_4 = 0;
                float3 _Vector3_1ACBBFC4_Out_0 = float3(_Multiply_D70B5F94_Out_2, _Split_68B7323B_G_2, _Split_68B7323B_R_1);
                float3 _Multiply_1C5CFCC5_Out_2;
                Unity_Multiply_float(_Vector3_1ACBBFC4_Out_0, (_Split_98088E33_R_1.xxx), _Multiply_1C5CFCC5_Out_2);
                float3 _Add_D483B2FD_Out_2;
                Unity_Add_float3(_Multiply_9E620CB9_Out_2, _Multiply_1C5CFCC5_Out_2, _Add_D483B2FD_Out_2);
                float3 _Add_166B5BED_Out_2;
                Unity_Add_float3(_Multiply_B99FFB12_Out_2, _Add_D483B2FD_Out_2, _Add_166B5BED_Out_2);
                float _Add_B73B64F6_Out_2;
                Unity_Add_float(_Split_98088E33_R_1, _Split_98088E33_G_2, _Add_B73B64F6_Out_2);
                float _Add_523B36E8_Out_2;
                Unity_Add_float(_Add_B73B64F6_Out_2, _Split_98088E33_B_3, _Add_523B36E8_Out_2);
                float3 _Divide_86C67C72_Out_2;
                Unity_Divide_float3(_Add_166B5BED_Out_2, (_Add_523B36E8_Out_2.xxx), _Divide_86C67C72_Out_2);
                float3x3 Transform_F679F94B_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_F679F94B_Out_1 = TransformWorldToTangent(_Divide_86C67C72_Out_2.xyz, Transform_F679F94B_tangentTransform_World);
                float3 _Normalize_E5F34A45_Out_1;
                Unity_Normalize_float3(_Transform_F679F94B_Out_1, _Normalize_E5F34A45_Out_1);
                XYZ_1 = (float4(_Normalize_E5F34A45_Out_1, 1.0));
                XZ_2 = (float4(_Vector3_A5ECB01F_Out_0, 1.0));
                YZ_3 = (float4(_Vector3_77AAFCD8_Out_0, 1.0));
                XY_4 = (float4(_Vector3_1ACBBFC4_Out_0, 1.0));
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpacePosition;
                #endif
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_ADEB2ED4;
                float3 _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_ADEB2ED4, _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 WorldSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 WorldSpaceBiTangent;
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
                float4 _Property_9FFBD215_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_DA44CA00_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_B8C9761A;
                _PlanarNM_B8C9761A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_B8C9761A.uv0 = IN.uv0;
                float4 _PlanarNM_B8C9761A_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNM_B8C9761A, _PlanarNM_B8C9761A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_BEF8608F_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_B633DE44_Out_2;
                Unity_Multiply_float(_PlanarNM_B8C9761A_XZ_2, _Property_BEF8608F_Out_0, _Multiply_B633DE44_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_884592D8_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_E65919DE_R_1 = _Property_884592D8_Out_0[0];
                float _Split_E65919DE_G_2 = _Property_884592D8_Out_0[1];
                float _Split_E65919DE_B_3 = _Property_884592D8_Out_0[2];
                float _Split_E65919DE_A_4 = _Property_884592D8_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_CD48789E_Out_0 = float2(_Split_E65919DE_R_1, _Split_E65919DE_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_C408B9B2_Out_0 = float2(_Split_E65919DE_B_3, _Split_E65919DE_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_CEF01838_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_CD48789E_Out_0, _Vector2_C408B9B2_Out_0, _TilingAndOffset_CEF01838_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_5927C7C9_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_CEF01838_Out_3);
                float _SampleTexture2D_5927C7C9_R_4 = _SampleTexture2D_5927C7C9_RGBA_0.r;
                float _SampleTexture2D_5927C7C9_G_5 = _SampleTexture2D_5927C7C9_RGBA_0.g;
                float _SampleTexture2D_5927C7C9_B_6 = _SampleTexture2D_5927C7C9_RGBA_0.b;
                float _SampleTexture2D_5927C7C9_A_7 = _SampleTexture2D_5927C7C9_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_564D6633_Out_2;
                Unity_Multiply_float(_SampleTexture2D_5927C7C9_R_4, 2, _Multiply_564D6633_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_DD5A18F0_Out_2;
                Unity_Add_float(_Multiply_564D6633_Out_2, -1, _Add_DD5A18F0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_ECF8584_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_8D57854C_Out_2;
                Unity_Multiply_float(_Add_DD5A18F0_Out_2, _Property_ECF8584_Out_0, _Multiply_8D57854C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_5C3AA762_Out_1;
                Unity_Saturate_float(_Multiply_8D57854C_Out_2, _Saturate_5C3AA762_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_A0608E3C_Out_1;
                Unity_Absolute_float(_Saturate_5C3AA762_Out_1, _Absolute_A0608E3C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_3A2278B0;
                float3 _BlendOverlayBaseColor_3A2278B0_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_B633DE44_Out_2, _Add_DD5A18F0_Out_2, _Absolute_A0608E3C_Out_1, _BlendOverlayBaseColor_3A2278B0, _BlendOverlayBaseColor_3A2278B0_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3CC54EA6_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Divide_2DD66DF0_Out_2;
                Unity_Divide_float4(float4(1, 1, 0, 0), _Property_3CC54EA6_Out_0, _Divide_2DD66DF0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F6956647_Out_0 = _CoverTriplanarThreshold;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_8999FBDB;
                _TriplanarNM_8999FBDB.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNM_8999FBDB.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNM_8999FBDB_XYZ_1;
                float4 _TriplanarNM_8999FBDB_XZ_2;
                float4 _TriplanarNM_8999FBDB_YZ_3;
                float4 _TriplanarNM_8999FBDB_XY_4;
                SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNM_8999FBDB, _TriplanarNM_8999FBDB_XYZ_1, _TriplanarNM_8999FBDB_XZ_2, _TriplanarNM_8999FBDB_YZ_3, _TriplanarNM_8999FBDB_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_6E2FED81_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_B1CF0578_Out_2;
                Unity_Multiply_float(_TriplanarNM_8999FBDB_XYZ_1, _Property_6E2FED81_Out_0, _Multiply_B1CF0578_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_44AAF8BF_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_3E2881E2_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_44AAF8BF_Out_0.xy));
                float _SampleTexture2D_3E2881E2_R_4 = _SampleTexture2D_3E2881E2_RGBA_0.r;
                float _SampleTexture2D_3E2881E2_G_5 = _SampleTexture2D_3E2881E2_RGBA_0.g;
                float _SampleTexture2D_3E2881E2_B_6 = _SampleTexture2D_3E2881E2_RGBA_0.b;
                float _SampleTexture2D_3E2881E2_A_7 = _SampleTexture2D_3E2881E2_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_3016ED3E_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_5D97A872_Out_2;
                Unity_Multiply_float(_SampleTexture2D_3E2881E2_A_7, _Property_3016ED3E_Out_0, _Multiply_5D97A872_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_1734BFE5_Out_3;
                Unity_Clamp_float(_Multiply_5D97A872_Out_2, 0, 1, _Clamp_1734BFE5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Property_932BDEF_Out_0 = _CoverDirection;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_11AF00D3_Out_0 = float2(_SampleTexture2D_5927C7C9_A_7, _SampleTexture2D_5927C7C9_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_96CC03D1_Out_2;
                Unity_Multiply_float(_Vector2_11AF00D3_Out_0, float2(2, 2), _Multiply_96CC03D1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_86574D0_Out_2;
                Unity_Add_float2(_Multiply_96CC03D1_Out_2, float2(-1, -1), _Add_86574D0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B1BD52A_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_F6F4ED16_Out_2;
                Unity_Multiply_float(_Add_86574D0_Out_2, (_Property_B1BD52A_Out_0.xx), _Multiply_F6F4ED16_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_70B6C51D_R_1 = _Multiply_F6F4ED16_Out_2[0];
                float _Split_70B6C51D_G_2 = _Multiply_F6F4ED16_Out_2[1];
                float _Split_70B6C51D_B_3 = 0;
                float _Split_70B6C51D_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _DotProduct_636FA5B4_Out_2;
                Unity_DotProduct_float2(_Multiply_F6F4ED16_Out_2, _Multiply_F6F4ED16_Out_2, _DotProduct_636FA5B4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_DB4FD3B4_Out_1;
                Unity_Saturate_float(_DotProduct_636FA5B4_Out_2, _Saturate_DB4FD3B4_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_B16221E6_Out_1;
                Unity_OneMinus_float(_Saturate_DB4FD3B4_Out_1, _OneMinus_B16221E6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _SquareRoot_E971D74E_Out_1;
                Unity_SquareRoot_float(_OneMinus_B16221E6_Out_1, _SquareRoot_E971D74E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Vector3_2B1829A1_Out_0 = float3(_Split_70B6C51D_R_1, _Split_70B6C51D_G_2, _SquareRoot_E971D74E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_C3762513;
                _PlanarNMn_C3762513.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_C3762513.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_C3762513.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_C3762513.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_C3762513.uv0 = IN.uv0;
                float4 _PlanarNMn_C3762513_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNMn_C3762513, _PlanarNMn_C3762513_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_904071D7_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_F54F97E9_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_C3762513_XZ_2.xyz), _Property_904071D7_Out_0, _NormalStrength_F54F97E9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalBlend_2EEFB9AF_Out_2;
                Unity_NormalBlend_float(_Vector3_2B1829A1_Out_0, _NormalStrength_F54F97E9_Out_2, _NormalBlend_2EEFB9AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8D3AA108;
                _TriplanarNMn_8D3AA108.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNMn_8D3AA108.WorldSpaceTangent = IN.WorldSpaceTangent;
                _TriplanarNMn_8D3AA108.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _TriplanarNMn_8D3AA108.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNMn_8D3AA108_XYZ_1;
                float4 _TriplanarNMn_8D3AA108_XZ_2;
                float4 _TriplanarNMn_8D3AA108_YZ_3;
                float4 _TriplanarNMn_8D3AA108_XY_4;
                SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNMn_8D3AA108, _TriplanarNMn_8D3AA108_XYZ_1, _TriplanarNMn_8D3AA108_XZ_2, _TriplanarNMn_8D3AA108_YZ_3, _TriplanarNMn_8D3AA108_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_995C1788_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_44BA1170_Out_2;
                Unity_NormalStrength_float((_TriplanarNMn_8D3AA108_XYZ_1.xyz), _Property_995C1788_Out_0, _NormalStrength_44BA1170_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Multiply_73E49A46_Out_2;
                Unity_Multiply_float(_Property_932BDEF_Out_0, IN.WorldSpaceNormal, _Multiply_73E49A46_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_D1026BB1_R_1 = _Multiply_73E49A46_Out_2[0];
                float _Split_D1026BB1_G_2 = _Multiply_73E49A46_Out_2[1];
                float _Split_D1026BB1_B_3 = _Multiply_73E49A46_Out_2[2];
                float _Split_D1026BB1_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_CCE93C47_Out_2;
                Unity_Add_float(_Split_D1026BB1_R_1, _Split_D1026BB1_G_2, _Add_CCE93C47_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_32345D47_Out_2;
                Unity_Add_float(_Add_CCE93C47_Out_2, _Split_D1026BB1_B_3, _Add_32345D47_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B1FFAD34_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_A2FAE14F_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_4B8044E8_Out_2;
                Unity_Subtract_float(4, _Property_A2FAE14F_Out_0, _Subtract_4B8044E8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_3B4F1D3A_Out_2;
                Unity_Divide_float(_Property_B1FFAD34_Out_0, _Subtract_4B8044E8_Out_2, _Divide_3B4F1D3A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_A4429D68_Out_1;
                Unity_Absolute_float(_Divide_3B4F1D3A_Out_2, _Absolute_A4429D68_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_FB9D1710_Out_2;
                Unity_Power_float(_Absolute_A4429D68_Out_1, _Subtract_4B8044E8_Out_2, _Power_FB9D1710_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_6B3FEC4_Out_3;
                Unity_Clamp_float(_Power_FB9D1710_Out_2, 0, 2, _Clamp_6B3FEC4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_8FBF66FA_Out_2;
                Unity_Multiply_float(_Add_32345D47_Out_2, _Clamp_6B3FEC4_Out_3, _Multiply_8FBF66FA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_9292D876_Out_1;
                Unity_Saturate_float(_Multiply_8FBF66FA_Out_2, _Saturate_9292D876_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_D0BC21C_Out_3;
                Unity_Clamp_float(_Add_32345D47_Out_2, 0, 0.9999, _Clamp_D0BC21C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B34EDBFD_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_B5480478_Out_2;
                Unity_Divide_float(_Property_B34EDBFD_Out_0, 45, _Divide_B5480478_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_CBCAD7A_Out_1;
                Unity_OneMinus_float(_Divide_B5480478_Out_2, _OneMinus_CBCAD7A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_EBEF174D_Out_2;
                Unity_Subtract_float(_Clamp_D0BC21C_Out_3, _OneMinus_CBCAD7A_Out_1, _Subtract_EBEF174D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_AA8A64A3_Out_3;
                Unity_Clamp_float(_Subtract_EBEF174D_Out_2, 0, 2, _Clamp_AA8A64A3_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_BFB32493_Out_2;
                Unity_Divide_float(1, _Divide_B5480478_Out_2, _Divide_BFB32493_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_B62964B9_Out_2;
                Unity_Multiply_float(_Clamp_AA8A64A3_Out_3, _Divide_BFB32493_Out_2, _Multiply_B62964B9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_7B34ADA9_Out_1;
                Unity_Absolute_float(_Multiply_B62964B9_Out_2, _Absolute_7B34ADA9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1DD92663_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_A1FB5EA0_Out_2;
                Unity_Power_float(_Absolute_7B34ADA9_Out_1, _Property_1DD92663_Out_0, _Power_A1FB5EA0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_C4852D4_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1AFBC8B2_Out_1;
                Unity_OneMinus_float(_Property_C4852D4_Out_0, _OneMinus_1AFBC8B2_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_DC11AC84_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_DC11AC84_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_DC11AC84_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_DC11AC84_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_86148D72_Out_2;
                Unity_Add_float(_OneMinus_1AFBC8B2_Out_1, _Split_DC11AC84_G_2, _Add_86148D72_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_39BC5217_Out_2;
                Unity_Add_float(_Add_86148D72_Out_2, 1, _Add_39BC5217_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_97F72B5E_Out_3;
                Unity_Clamp_float(_Add_39BC5217_Out_2, 0, 1, _Clamp_97F72B5E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_28703D9B_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_38B3D359_Out_2;
                Unity_Add_float(_Add_86148D72_Out_2, _Property_28703D9B_Out_0, _Add_38B3D359_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_407B44D8_Out_2;
                Unity_Divide_float(_Add_38B3D359_Out_2, _Add_86148D72_Out_2, _Divide_407B44D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_789A0D0E_Out_1;
                Unity_OneMinus_float(_Divide_407B44D8_Out_2, _OneMinus_789A0D0E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_7428640F_Out_2;
                Unity_Add_float(_OneMinus_789A0D0E_Out_1, -0.5, _Add_7428640F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_9C76860B_Out_3;
                Unity_Clamp_float(_Add_7428640F_Out_2, 0, 1, _Clamp_9C76860B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F1ED053D_Out_2;
                Unity_Add_float(_Clamp_97F72B5E_Out_3, _Clamp_9C76860B_Out_3, _Add_F1ED053D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_BFC65370_Out_3;
                Unity_Clamp_float(_Add_F1ED053D_Out_2, 0, 1, _Clamp_BFC65370_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_180E431B_Out_2;
                Unity_Multiply_float(_Power_A1FB5EA0_Out_2, _Clamp_BFC65370_Out_3, _Multiply_180E431B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_C26F02DA_Out_2;
                Unity_Multiply_float(_Saturate_9292D876_Out_1, _Multiply_180E431B_Out_2, _Multiply_C26F02DA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_3522A454_Out_3;
                Unity_Lerp_float3(_NormalBlend_2EEFB9AF_Out_2, _NormalStrength_44BA1170_Out_2, (_Multiply_C26F02DA_Out_2.xxx), _Lerp_3522A454_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_14C81C91_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_14C81C91_Out_1 = normalize(mul(Transform_14C81C91_transposeTangent, _Lerp_3522A454_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Multiply_1B01DF43_Out_2;
                Unity_Multiply_float(_Property_932BDEF_Out_0, _Transform_14C81C91_Out_1, _Multiply_1B01DF43_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_A0DF36AC_R_1 = _Multiply_1B01DF43_Out_2[0];
                float _Split_A0DF36AC_G_2 = _Multiply_1B01DF43_Out_2[1];
                float _Split_A0DF36AC_B_3 = _Multiply_1B01DF43_Out_2[2];
                float _Split_A0DF36AC_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_CDFDCB4A_Out_2;
                Unity_Add_float(_Split_A0DF36AC_R_1, _Split_A0DF36AC_G_2, _Add_CDFDCB4A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D6F78AB0_Out_2;
                Unity_Add_float(_Add_CDFDCB4A_Out_2, _Split_A0DF36AC_B_3, _Add_D6F78AB0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_955E55F1_Out_2;
                Unity_Multiply_float(_Add_D6F78AB0_Out_2, _Clamp_6B3FEC4_Out_3, _Multiply_955E55F1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2AF9B3D_Out_2;
                Unity_Multiply_float(_Clamp_6B3FEC4_Out_3, _Property_1DD92663_Out_0, _Multiply_2AF9B3D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F6BB913B_Out_2;
                Unity_Multiply_float(_Multiply_2AF9B3D_Out_2, _Multiply_180E431B_Out_2, _Multiply_F6BB913B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2FBE96C8_Out_2;
                Unity_Multiply_float(_Multiply_955E55F1_Out_2, _Multiply_F6BB913B_Out_2, _Multiply_2FBE96C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_4DA318C7;
                _TriplanarNM_4DA318C7.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNM_4DA318C7.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNM_4DA318C7_XYZ_1;
                float4 _TriplanarNM_4DA318C7_XZ_2;
                float4 _TriplanarNM_4DA318C7_YZ_3;
                float4 _TriplanarNM_4DA318C7_XY_4;
                SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNM_4DA318C7, _TriplanarNM_4DA318C7_XYZ_1, _TriplanarNM_4DA318C7_XZ_2, _TriplanarNM_4DA318C7_YZ_3, _TriplanarNM_4DA318C7_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_886A1366_R_1 = _TriplanarNM_4DA318C7_XYZ_1[0];
                float _Split_886A1366_G_2 = _TriplanarNM_4DA318C7_XYZ_1[1];
                float _Split_886A1366_B_3 = _TriplanarNM_4DA318C7_XYZ_1[2];
                float _Split_886A1366_A_4 = _TriplanarNM_4DA318C7_XYZ_1[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9F3C748A_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_38F71BFB_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_E157D4E8_Out_0 = float2(_Property_9F3C748A_Out_0, _Property_38F71BFB_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_514307DE_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_42D344B7_Out_2;
                Unity_Add_float2(_Vector2_E157D4E8_Out_0, (_Property_514307DE_Out_0.xx), _Add_42D344B7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_BD5FD283_Out_3;
                Unity_Remap_float(_Split_886A1366_B_3, float2 (0, 1), _Add_42D344B7_Out_2, _Remap_BD5FD283_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_AA9F17C9_Out_2;
                Unity_Multiply_float(_Multiply_2FBE96C8_Out_2, _Remap_BD5FD283_Out_3, _Multiply_AA9F17C9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_B5BA182F_R_1 = IN.VertexColor[0];
                float _Split_B5BA182F_G_2 = IN.VertexColor[1];
                float _Split_B5BA182F_B_3 = IN.VertexColor[2];
                float _Split_B5BA182F_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_17BF6B0_Out_2;
                Unity_Multiply_float(_Multiply_AA9F17C9_Out_2, _Split_B5BA182F_G_2, _Multiply_17BF6B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_E4AE5990_Out_1;
                Unity_Saturate_float(_Multiply_17BF6B0_Out_2, _Saturate_E4AE5990_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_80D50DF7_Out_2;
                Unity_Multiply_float(_Clamp_1734BFE5_Out_3, _Saturate_E4AE5990_Out_1, _Multiply_80D50DF7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_D675BDBA_Out_0 = _Multiply_80D50DF7_Out_2;
                #else
                float _UseDynamicCoverTStaticMaskF_D675BDBA_Out_0 = _Clamp_1734BFE5_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_62655FB2_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_3A2278B0_OutVector4_1, (_Multiply_B1CF0578_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_D675BDBA_Out_0.xxx), _Lerp_62655FB2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_9F64AEAF_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_4AEEE38_Out_2;
                Unity_Multiply_float((_Property_9F64AEAF_Out_0.xyz), _Lerp_62655FB2_Out_3, _Multiply_4AEEE38_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_1558D782_Out_1;
                Unity_OneMinus_float(_Split_B5BA182F_R_1, _OneMinus_1558D782_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_70281627_Out_3;
                Unity_Lerp_float3(_Lerp_62655FB2_Out_3, _Multiply_4AEEE38_Out_2, (_OneMinus_1558D782_Out_1.xxx), _Lerp_70281627_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A449C527_R_1 = _PlanarNM_B8C9761A_XZ_2[0];
                float _Split_A449C527_G_2 = _PlanarNM_B8C9761A_XZ_2[1];
                float _Split_A449C527_B_3 = _PlanarNM_B8C9761A_XZ_2[2];
                float _Split_A449C527_A_4 = _PlanarNM_B8C9761A_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EDD4395E_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_70281627_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Alpha = _Split_A449C527_A_4;
                surface.AlphaClipThreshold = _Property_EDD4395E_Out_0;
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
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float4 tangentWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
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
            
            #if defined(KEYWORD_PERMUTATION_0)
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
                output.interp04.xyzw = input.color;
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
                output.color = input.interp04.xyzw;
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
            #elif defined(KEYWORD_PERMUTATION_1)
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
                output.interp02.xyzw = input.texCoord0;
                output.interp03.xyzw = input.color;
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
                output.texCoord0 = input.interp02.xyzw;
                output.color = input.interp03.xyzw;
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
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceNormal =           input.normalOS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceTangent =          input.tangentOS;
            #endif
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpacePosition =         input.positionOS;
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0)
            // use bitangent on the fly like in hdrp
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0)
            // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            // This is explained in section 2.2 in "surface gradient based bump mapping framework"
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            output.WorldSpaceBiTangent =         renormFactor*bitang;
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
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
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
        
        #if defined(KEYWORD_PERMUTATION_0)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        
        
        
        
        
            #define FEATURES_GRAPH_VERTEX
            #define SHADERPASS_2D
        
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
            float _AlphaCutoff;
            float4 _BaseColor;
            float _BaseUsePlanarUV;
            float4 _BaseTilingOffset;
            float4 _SpecularColor;
            float _BaseNormalScale;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float3 _CoverDirection;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverTriplanarThreshold;
            float4 _CoverSpecularColor;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
            float _CoverHeightMapMin;
            float _CoverHeightMapMax;
            float _CoverHeightMapOffset;
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
            TEXTURE2D(_SpecularColorMap); SAMPLER(sampler_SpecularColorMap); float4 _SpecularColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverSpecularColorMap); SAMPLER(sampler_CoverSpecularColorMap); float4 _CoverSpecularColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_5927C7C9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_66E4959F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_96366F41_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_3E2881E2_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // c7f63929085c93b4f2216b914e6e81d6
            #include "Assets/NatureManufacture Assets/Object Shaders/NM_Object_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b
            {
            };
            
            void SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(float3 Vector3_314C8600, Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
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
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
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
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
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
            
            void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A / B;
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Absolute_float3(float3 In, out float3 Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float3(float3 A, float3 B, out float3 Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A + B;
            }
            
            struct Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea
            {
                float3 WorldSpaceNormal;
                float3 AbsoluteWorldSpacePosition;
            };
            
            void SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
            {
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float _Property_7A4DC59B_Out_0 = Vector1_41461AC9;
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_D99671F1_Out_2);
                float3 _Sign_C0850857_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_C0850857_Out_1);
                float _Split_EEBC69B5_R_1 = _Sign_C0850857_Out_1[0];
                float _Split_EEBC69B5_G_2 = _Sign_C0850857_Out_1[1];
                float _Split_EEBC69B5_B_3 = _Sign_C0850857_Out_1[2];
                float _Split_EEBC69B5_A_4 = 0;
                float2 _Vector2_7598EA98_Out_0 = float2(_Split_EEBC69B5_G_2, 1);
                float2 _Multiply_F82F3FE2_Out_2;
                Unity_Multiply_float((_Multiply_D99671F1_Out_2.xy), _Vector2_7598EA98_Out_0, _Multiply_F82F3FE2_Out_2);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_F82F3FE2_Out_2);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float3 _Absolute_FF95EDEB_Out_1;
                Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_FF95EDEB_Out_1);
                float _Property_F8688E0_Out_0 = Vector1_E4D1C13A;
                float3 _Power_C741CD3A_Out_2;
                Unity_Power_float3(_Absolute_FF95EDEB_Out_1, (_Property_F8688E0_Out_0.xxx), _Power_C741CD3A_Out_2);
                float3 _Multiply_3FB4A346_Out_2;
                Unity_Multiply_float(_Power_C741CD3A_Out_2, _Power_C741CD3A_Out_2, _Multiply_3FB4A346_Out_2);
                float _Split_98088E33_R_1 = _Multiply_3FB4A346_Out_2[0];
                float _Split_98088E33_G_2 = _Multiply_3FB4A346_Out_2[1];
                float _Split_98088E33_B_3 = _Multiply_3FB4A346_Out_2[2];
                float _Split_98088E33_A_4 = 0;
                float4 _Multiply_B99FFB12_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_RGBA_0, (_Split_98088E33_G_2.xxxx), _Multiply_B99FFB12_Out_2);
                float4 _Combine_EAF808EA_RGBA_4;
                float3 _Combine_EAF808EA_RGB_5;
                float2 _Combine_EAF808EA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_G_2, 0, 0, _Combine_EAF808EA_RGBA_4, _Combine_EAF808EA_RGB_5, _Combine_EAF808EA_RG_6);
                float4 _Multiply_9B855117_Out_2;
                Unity_Multiply_float(_Combine_EAF808EA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_9B855117_Out_2);
                float _Multiply_B8AC16FB_Out_2;
                Unity_Multiply_float(_Split_EEBC69B5_B_3, -1, _Multiply_B8AC16FB_Out_2);
                float2 _Vector2_F031282A_Out_0 = float2(_Multiply_B8AC16FB_Out_2, 1);
                float2 _Multiply_89A39D70_Out_2;
                Unity_Multiply_float((_Multiply_9B855117_Out_2.xy), _Vector2_F031282A_Out_0, _Multiply_89A39D70_Out_2);
                float4 _SampleTexture2D_66E4959F_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_89A39D70_Out_2);
                float _SampleTexture2D_66E4959F_R_4 = _SampleTexture2D_66E4959F_RGBA_0.r;
                float _SampleTexture2D_66E4959F_G_5 = _SampleTexture2D_66E4959F_RGBA_0.g;
                float _SampleTexture2D_66E4959F_B_6 = _SampleTexture2D_66E4959F_RGBA_0.b;
                float _SampleTexture2D_66E4959F_A_7 = _SampleTexture2D_66E4959F_RGBA_0.a;
                float4 _Multiply_9E620CB9_Out_2;
                Unity_Multiply_float(_SampleTexture2D_66E4959F_RGBA_0, (_Split_98088E33_B_3.xxxx), _Multiply_9E620CB9_Out_2);
                float4 _Combine_D494A8E_RGBA_4;
                float3 _Combine_D494A8E_RGB_5;
                float2 _Combine_D494A8E_RG_6;
                Unity_Combine_float(_Split_34F118DC_B_3, _Split_34F118DC_G_2, 0, 0, _Combine_D494A8E_RGBA_4, _Combine_D494A8E_RGB_5, _Combine_D494A8E_RG_6);
                float4 _Multiply_1B29A9F1_Out_2;
                Unity_Multiply_float(_Combine_D494A8E_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_1B29A9F1_Out_2);
                float2 _Vector2_1F147BEC_Out_0 = float2(_Split_EEBC69B5_R_1, 1);
                float2 _Multiply_5B8B54E9_Out_2;
                Unity_Multiply_float((_Multiply_1B29A9F1_Out_2.xy), _Vector2_1F147BEC_Out_0, _Multiply_5B8B54E9_Out_2);
                float4 _SampleTexture2D_96366F41_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_5B8B54E9_Out_2);
                float _SampleTexture2D_96366F41_R_4 = _SampleTexture2D_96366F41_RGBA_0.r;
                float _SampleTexture2D_96366F41_G_5 = _SampleTexture2D_96366F41_RGBA_0.g;
                float _SampleTexture2D_96366F41_B_6 = _SampleTexture2D_96366F41_RGBA_0.b;
                float _SampleTexture2D_96366F41_A_7 = _SampleTexture2D_96366F41_RGBA_0.a;
                float4 _Multiply_1C5CFCC5_Out_2;
                Unity_Multiply_float(_SampleTexture2D_96366F41_RGBA_0, (_Split_98088E33_R_1.xxxx), _Multiply_1C5CFCC5_Out_2);
                float4 _Add_D483B2FD_Out_2;
                Unity_Add_float4(_Multiply_9E620CB9_Out_2, _Multiply_1C5CFCC5_Out_2, _Add_D483B2FD_Out_2);
                float4 _Add_166B5BED_Out_2;
                Unity_Add_float4(_Multiply_B99FFB12_Out_2, _Add_D483B2FD_Out_2, _Add_166B5BED_Out_2);
                float _Add_B73B64F6_Out_2;
                Unity_Add_float(_Split_98088E33_R_1, _Split_98088E33_G_2, _Add_B73B64F6_Out_2);
                float _Add_523B36E8_Out_2;
                Unity_Add_float(_Add_B73B64F6_Out_2, _Split_98088E33_B_3, _Add_523B36E8_Out_2);
                float4 _Divide_86C67C72_Out_2;
                Unity_Divide_float4(_Add_166B5BED_Out_2, (_Add_523B36E8_Out_2.xxxx), _Divide_86C67C72_Out_2);
                XYZ_1 = _Divide_86C67C72_Out_2;
                XZ_2 = _SampleTexture2D_AF934D9A_RGBA_0;
                YZ_3 = _SampleTexture2D_66E4959F_RGBA_0;
                XY_4 = _SampleTexture2D_96366F41_RGBA_0;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
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
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A / B;
            }
            
            struct Bindings_TriplanarNMn_059da9746584140498cd018db3c76047
            {
                float3 WorldSpaceNormal;
                float3 WorldSpaceTangent;
                float3 WorldSpaceBiTangent;
                float3 AbsoluteWorldSpacePosition;
            };
            
            void SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_PARAM(Texture2D_80A3D28F, samplerTexture2D_80A3D28F), float4 Texture2D_80A3D28F_TexelSize, float Vector1_41461AC9, float Vector1_E4D1C13A, Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 IN, out float4 XYZ_1, out float4 XZ_2, out float4 YZ_3, out float4 XY_4)
            {
                float _Split_34F118DC_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34F118DC_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34F118DC_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34F118DC_A_4 = 0;
                float4 _Combine_FDBD63CA_RGBA_4;
                float3 _Combine_FDBD63CA_RGB_5;
                float2 _Combine_FDBD63CA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_B_3, 0, 0, _Combine_FDBD63CA_RGBA_4, _Combine_FDBD63CA_RGB_5, _Combine_FDBD63CA_RG_6);
                float _Property_7A4DC59B_Out_0 = Vector1_41461AC9;
                float4 _Multiply_D99671F1_Out_2;
                Unity_Multiply_float(_Combine_FDBD63CA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_D99671F1_Out_2);
                float3 _Sign_937BD7C4_Out_1;
                Unity_Sign_float3(IN.WorldSpaceNormal, _Sign_937BD7C4_Out_1);
                float _Split_A88C5CBA_R_1 = _Sign_937BD7C4_Out_1[0];
                float _Split_A88C5CBA_G_2 = _Sign_937BD7C4_Out_1[1];
                float _Split_A88C5CBA_B_3 = _Sign_937BD7C4_Out_1[2];
                float _Split_A88C5CBA_A_4 = 0;
                float2 _Vector2_DC7A07A_Out_0 = float2(_Split_A88C5CBA_G_2, 1);
                float2 _Multiply_6E58BF97_Out_2;
                Unity_Multiply_float((_Multiply_D99671F1_Out_2.xy), _Vector2_DC7A07A_Out_0, _Multiply_6E58BF97_Out_2);
                float4 _SampleTexture2D_AF934D9A_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_6E58BF97_Out_2);
                _SampleTexture2D_AF934D9A_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AF934D9A_RGBA_0);
                float _SampleTexture2D_AF934D9A_R_4 = _SampleTexture2D_AF934D9A_RGBA_0.r;
                float _SampleTexture2D_AF934D9A_G_5 = _SampleTexture2D_AF934D9A_RGBA_0.g;
                float _SampleTexture2D_AF934D9A_B_6 = _SampleTexture2D_AF934D9A_RGBA_0.b;
                float _SampleTexture2D_AF934D9A_A_7 = _SampleTexture2D_AF934D9A_RGBA_0.a;
                float2 _Vector2_699A5DA1_Out_0 = float2(_SampleTexture2D_AF934D9A_R_4, _SampleTexture2D_AF934D9A_G_5);
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
                float _Multiply_97283B7E_Out_2;
                Unity_Multiply_float(_SampleTexture2D_AF934D9A_B_6, _Split_CE0AB7C6_G_2, _Multiply_97283B7E_Out_2);
                float3 _Vector3_A5ECB01F_Out_0 = float3(_Split_1D7F6EE9_R_1, _Multiply_97283B7E_Out_2, _Split_1D7F6EE9_G_2);
                float3 _Absolute_FF95EDEB_Out_1;
                Unity_Absolute_float3(IN.WorldSpaceNormal, _Absolute_FF95EDEB_Out_1);
                float _Property_F8688E0_Out_0 = Vector1_E4D1C13A;
                float3 _Power_C741CD3A_Out_2;
                Unity_Power_float3(_Absolute_FF95EDEB_Out_1, (_Property_F8688E0_Out_0.xxx), _Power_C741CD3A_Out_2);
                float3 _Multiply_3FB4A346_Out_2;
                Unity_Multiply_float(_Power_C741CD3A_Out_2, _Power_C741CD3A_Out_2, _Multiply_3FB4A346_Out_2);
                float _Split_98088E33_R_1 = _Multiply_3FB4A346_Out_2[0];
                float _Split_98088E33_G_2 = _Multiply_3FB4A346_Out_2[1];
                float _Split_98088E33_B_3 = _Multiply_3FB4A346_Out_2[2];
                float _Split_98088E33_A_4 = 0;
                float3 _Multiply_B99FFB12_Out_2;
                Unity_Multiply_float(_Vector3_A5ECB01F_Out_0, (_Split_98088E33_G_2.xxx), _Multiply_B99FFB12_Out_2);
                float4 _Combine_EAF808EA_RGBA_4;
                float3 _Combine_EAF808EA_RGB_5;
                float2 _Combine_EAF808EA_RG_6;
                Unity_Combine_float(_Split_34F118DC_R_1, _Split_34F118DC_G_2, 0, 0, _Combine_EAF808EA_RGBA_4, _Combine_EAF808EA_RGB_5, _Combine_EAF808EA_RG_6);
                float4 _Multiply_9B855117_Out_2;
                Unity_Multiply_float(_Combine_EAF808EA_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_9B855117_Out_2);
                float _Multiply_9028821C_Out_2;
                Unity_Multiply_float(_Split_A88C5CBA_B_3, -1, _Multiply_9028821C_Out_2);
                float2 _Vector2_34183E31_Out_0 = float2(_Multiply_9028821C_Out_2, 1);
                float2 _Multiply_25D3DEE7_Out_2;
                Unity_Multiply_float((_Multiply_9B855117_Out_2.xy), _Vector2_34183E31_Out_0, _Multiply_25D3DEE7_Out_2);
                float4 _SampleTexture2D_66E4959F_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_25D3DEE7_Out_2);
                _SampleTexture2D_66E4959F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_66E4959F_RGBA_0);
                float _SampleTexture2D_66E4959F_R_4 = _SampleTexture2D_66E4959F_RGBA_0.r;
                float _SampleTexture2D_66E4959F_G_5 = _SampleTexture2D_66E4959F_RGBA_0.g;
                float _SampleTexture2D_66E4959F_B_6 = _SampleTexture2D_66E4959F_RGBA_0.b;
                float _SampleTexture2D_66E4959F_A_7 = _SampleTexture2D_66E4959F_RGBA_0.a;
                float2 _Vector2_6CC92971_Out_0 = float2(_SampleTexture2D_66E4959F_R_4, _SampleTexture2D_66E4959F_G_5);
                float2 _Multiply_EDE2F02C_Out_2;
                Unity_Multiply_float(_Vector2_6CC92971_Out_0, _Vector2_34183E31_Out_0, _Multiply_EDE2F02C_Out_2);
                float2 _Vector2_6D428360_Out_0 = float2(_Split_CE0AB7C6_R_1, _Split_CE0AB7C6_G_2);
                float2 _Add_6D3412BD_Out_2;
                Unity_Add_float2(_Multiply_EDE2F02C_Out_2, _Vector2_6D428360_Out_0, _Add_6D3412BD_Out_2);
                float _Split_79C8538A_R_1 = _Add_6D3412BD_Out_2[0];
                float _Split_79C8538A_G_2 = _Add_6D3412BD_Out_2[1];
                float _Split_79C8538A_B_3 = 0;
                float _Split_79C8538A_A_4 = 0;
                float _Multiply_576DD59F_Out_2;
                Unity_Multiply_float(_SampleTexture2D_66E4959F_B_6, _Split_CE0AB7C6_B_3, _Multiply_576DD59F_Out_2);
                float3 _Vector3_77AAFCD8_Out_0 = float3(_Split_79C8538A_R_1, _Split_79C8538A_G_2, _Multiply_576DD59F_Out_2);
                float3 _Multiply_9E620CB9_Out_2;
                Unity_Multiply_float(_Vector3_77AAFCD8_Out_0, (_Split_98088E33_B_3.xxx), _Multiply_9E620CB9_Out_2);
                float4 _Combine_D494A8E_RGBA_4;
                float3 _Combine_D494A8E_RGB_5;
                float2 _Combine_D494A8E_RG_6;
                Unity_Combine_float(_Split_34F118DC_B_3, _Split_34F118DC_G_2, 0, 0, _Combine_D494A8E_RGBA_4, _Combine_D494A8E_RGB_5, _Combine_D494A8E_RG_6);
                float4 _Multiply_1B29A9F1_Out_2;
                Unity_Multiply_float(_Combine_D494A8E_RGBA_4, (_Property_7A4DC59B_Out_0.xxxx), _Multiply_1B29A9F1_Out_2);
                float2 _Vector2_2EDA3EA2_Out_0 = float2(_Split_A88C5CBA_R_1, 1);
                float2 _Multiply_4083C468_Out_2;
                Unity_Multiply_float((_Multiply_1B29A9F1_Out_2.xy), _Vector2_2EDA3EA2_Out_0, _Multiply_4083C468_Out_2);
                float4 _SampleTexture2D_96366F41_RGBA_0 = SAMPLE_TEXTURE2D(Texture2D_80A3D28F, samplerTexture2D_80A3D28F, _Multiply_4083C468_Out_2);
                _SampleTexture2D_96366F41_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_96366F41_RGBA_0);
                float _SampleTexture2D_96366F41_R_4 = _SampleTexture2D_96366F41_RGBA_0.r;
                float _SampleTexture2D_96366F41_G_5 = _SampleTexture2D_96366F41_RGBA_0.g;
                float _SampleTexture2D_96366F41_B_6 = _SampleTexture2D_96366F41_RGBA_0.b;
                float _SampleTexture2D_96366F41_A_7 = _SampleTexture2D_96366F41_RGBA_0.a;
                float _Multiply_D70B5F94_Out_2;
                Unity_Multiply_float(_SampleTexture2D_96366F41_B_6, _Split_CE0AB7C6_R_1, _Multiply_D70B5F94_Out_2);
                float2 _Vector2_D6F48DBF_Out_0 = float2(_SampleTexture2D_96366F41_R_4, _SampleTexture2D_96366F41_G_5);
                float2 _Multiply_32364D17_Out_2;
                Unity_Multiply_float(_Vector2_D6F48DBF_Out_0, _Vector2_2EDA3EA2_Out_0, _Multiply_32364D17_Out_2);
                float2 _Vector2_5861421E_Out_0 = float2(_Split_CE0AB7C6_B_3, _Split_CE0AB7C6_G_2);
                float2 _Add_15B5B6DC_Out_2;
                Unity_Add_float2(_Multiply_32364D17_Out_2, _Vector2_5861421E_Out_0, _Add_15B5B6DC_Out_2);
                float _Split_68B7323B_R_1 = _Add_15B5B6DC_Out_2[0];
                float _Split_68B7323B_G_2 = _Add_15B5B6DC_Out_2[1];
                float _Split_68B7323B_B_3 = 0;
                float _Split_68B7323B_A_4 = 0;
                float3 _Vector3_1ACBBFC4_Out_0 = float3(_Multiply_D70B5F94_Out_2, _Split_68B7323B_G_2, _Split_68B7323B_R_1);
                float3 _Multiply_1C5CFCC5_Out_2;
                Unity_Multiply_float(_Vector3_1ACBBFC4_Out_0, (_Split_98088E33_R_1.xxx), _Multiply_1C5CFCC5_Out_2);
                float3 _Add_D483B2FD_Out_2;
                Unity_Add_float3(_Multiply_9E620CB9_Out_2, _Multiply_1C5CFCC5_Out_2, _Add_D483B2FD_Out_2);
                float3 _Add_166B5BED_Out_2;
                Unity_Add_float3(_Multiply_B99FFB12_Out_2, _Add_D483B2FD_Out_2, _Add_166B5BED_Out_2);
                float _Add_B73B64F6_Out_2;
                Unity_Add_float(_Split_98088E33_R_1, _Split_98088E33_G_2, _Add_B73B64F6_Out_2);
                float _Add_523B36E8_Out_2;
                Unity_Add_float(_Add_B73B64F6_Out_2, _Split_98088E33_B_3, _Add_523B36E8_Out_2);
                float3 _Divide_86C67C72_Out_2;
                Unity_Divide_float3(_Add_166B5BED_Out_2, (_Add_523B36E8_Out_2.xxx), _Divide_86C67C72_Out_2);
                float3x3 Transform_F679F94B_tangentTransform_World = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
                float3 _Transform_F679F94B_Out_1 = TransformWorldToTangent(_Divide_86C67C72_Out_2.xyz, Transform_F679F94B_tangentTransform_World);
                float3 _Normalize_E5F34A45_Out_1;
                Unity_Normalize_float3(_Transform_F679F94B_Out_1, _Normalize_E5F34A45_Out_1);
                XYZ_1 = (float4(_Normalize_E5F34A45_Out_1, 1.0));
                XZ_2 = (float4(_Vector3_A5ECB01F_Out_0, 1.0));
                YZ_3 = (float4(_Vector3_77AAFCD8_Out_0, 1.0));
                XY_4 = (float4(_Vector3_1ACBBFC4_Out_0, 1.0));
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 ObjectSpacePosition;
                #endif
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_ADEB2ED4;
                float3 _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_ADEB2ED4, _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_ADEB2ED4_ObjectSpacePosition_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 WorldSpaceTangent;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 WorldSpaceBiTangent;
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
                float4 _Property_9FFBD215_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_DA44CA00_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_B8C9761A;
                _PlanarNM_B8C9761A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_B8C9761A.uv0 = IN.uv0;
                float4 _PlanarNM_B8C9761A_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNM_B8C9761A, _PlanarNM_B8C9761A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_BEF8608F_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_B633DE44_Out_2;
                Unity_Multiply_float(_PlanarNM_B8C9761A_XZ_2, _Property_BEF8608F_Out_0, _Multiply_B633DE44_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_884592D8_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_E65919DE_R_1 = _Property_884592D8_Out_0[0];
                float _Split_E65919DE_G_2 = _Property_884592D8_Out_0[1];
                float _Split_E65919DE_B_3 = _Property_884592D8_Out_0[2];
                float _Split_E65919DE_A_4 = _Property_884592D8_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_CD48789E_Out_0 = float2(_Split_E65919DE_R_1, _Split_E65919DE_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_C408B9B2_Out_0 = float2(_Split_E65919DE_B_3, _Split_E65919DE_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_CEF01838_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_CD48789E_Out_0, _Vector2_C408B9B2_Out_0, _TilingAndOffset_CEF01838_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_5927C7C9_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_CEF01838_Out_3);
                float _SampleTexture2D_5927C7C9_R_4 = _SampleTexture2D_5927C7C9_RGBA_0.r;
                float _SampleTexture2D_5927C7C9_G_5 = _SampleTexture2D_5927C7C9_RGBA_0.g;
                float _SampleTexture2D_5927C7C9_B_6 = _SampleTexture2D_5927C7C9_RGBA_0.b;
                float _SampleTexture2D_5927C7C9_A_7 = _SampleTexture2D_5927C7C9_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_564D6633_Out_2;
                Unity_Multiply_float(_SampleTexture2D_5927C7C9_R_4, 2, _Multiply_564D6633_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_DD5A18F0_Out_2;
                Unity_Add_float(_Multiply_564D6633_Out_2, -1, _Add_DD5A18F0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_ECF8584_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_8D57854C_Out_2;
                Unity_Multiply_float(_Add_DD5A18F0_Out_2, _Property_ECF8584_Out_0, _Multiply_8D57854C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_5C3AA762_Out_1;
                Unity_Saturate_float(_Multiply_8D57854C_Out_2, _Saturate_5C3AA762_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_A0608E3C_Out_1;
                Unity_Absolute_float(_Saturate_5C3AA762_Out_1, _Absolute_A0608E3C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_3A2278B0;
                float3 _BlendOverlayBaseColor_3A2278B0_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_B633DE44_Out_2, _Add_DD5A18F0_Out_2, _Absolute_A0608E3C_Out_1, _BlendOverlayBaseColor_3A2278B0, _BlendOverlayBaseColor_3A2278B0_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_3CC54EA6_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Divide_2DD66DF0_Out_2;
                Unity_Divide_float4(float4(1, 1, 0, 0), _Property_3CC54EA6_Out_0, _Divide_2DD66DF0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F6956647_Out_0 = _CoverTriplanarThreshold;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_8999FBDB;
                _TriplanarNM_8999FBDB.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNM_8999FBDB.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNM_8999FBDB_XYZ_1;
                float4 _TriplanarNM_8999FBDB_XZ_2;
                float4 _TriplanarNM_8999FBDB_YZ_3;
                float4 _TriplanarNM_8999FBDB_XY_4;
                SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNM_8999FBDB, _TriplanarNM_8999FBDB_XYZ_1, _TriplanarNM_8999FBDB_XZ_2, _TriplanarNM_8999FBDB_YZ_3, _TriplanarNM_8999FBDB_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_6E2FED81_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_B1CF0578_Out_2;
                Unity_Multiply_float(_TriplanarNM_8999FBDB_XYZ_1, _Property_6E2FED81_Out_0, _Multiply_B1CF0578_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_44AAF8BF_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_3E2881E2_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_44AAF8BF_Out_0.xy));
                float _SampleTexture2D_3E2881E2_R_4 = _SampleTexture2D_3E2881E2_RGBA_0.r;
                float _SampleTexture2D_3E2881E2_G_5 = _SampleTexture2D_3E2881E2_RGBA_0.g;
                float _SampleTexture2D_3E2881E2_B_6 = _SampleTexture2D_3E2881E2_RGBA_0.b;
                float _SampleTexture2D_3E2881E2_A_7 = _SampleTexture2D_3E2881E2_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_3016ED3E_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_5D97A872_Out_2;
                Unity_Multiply_float(_SampleTexture2D_3E2881E2_A_7, _Property_3016ED3E_Out_0, _Multiply_5D97A872_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_1734BFE5_Out_3;
                Unity_Clamp_float(_Multiply_5D97A872_Out_2, 0, 1, _Clamp_1734BFE5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Property_932BDEF_Out_0 = _CoverDirection;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_11AF00D3_Out_0 = float2(_SampleTexture2D_5927C7C9_A_7, _SampleTexture2D_5927C7C9_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_96CC03D1_Out_2;
                Unity_Multiply_float(_Vector2_11AF00D3_Out_0, float2(2, 2), _Multiply_96CC03D1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_86574D0_Out_2;
                Unity_Add_float2(_Multiply_96CC03D1_Out_2, float2(-1, -1), _Add_86574D0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B1BD52A_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_F6F4ED16_Out_2;
                Unity_Multiply_float(_Add_86574D0_Out_2, (_Property_B1BD52A_Out_0.xx), _Multiply_F6F4ED16_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_70B6C51D_R_1 = _Multiply_F6F4ED16_Out_2[0];
                float _Split_70B6C51D_G_2 = _Multiply_F6F4ED16_Out_2[1];
                float _Split_70B6C51D_B_3 = 0;
                float _Split_70B6C51D_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _DotProduct_636FA5B4_Out_2;
                Unity_DotProduct_float2(_Multiply_F6F4ED16_Out_2, _Multiply_F6F4ED16_Out_2, _DotProduct_636FA5B4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_DB4FD3B4_Out_1;
                Unity_Saturate_float(_DotProduct_636FA5B4_Out_2, _Saturate_DB4FD3B4_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_B16221E6_Out_1;
                Unity_OneMinus_float(_Saturate_DB4FD3B4_Out_1, _OneMinus_B16221E6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _SquareRoot_E971D74E_Out_1;
                Unity_SquareRoot_float(_OneMinus_B16221E6_Out_1, _SquareRoot_E971D74E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Vector3_2B1829A1_Out_0 = float3(_Split_70B6C51D_R_1, _Split_70B6C51D_G_2, _SquareRoot_E971D74E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_C3762513;
                _PlanarNMn_C3762513.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_C3762513.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_C3762513.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_C3762513.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_C3762513.uv0 = IN.uv0;
                float4 _PlanarNMn_C3762513_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_9FFBD215_Out_0, _Property_DA44CA00_Out_0, _PlanarNMn_C3762513, _PlanarNMn_C3762513_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_904071D7_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_F54F97E9_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_C3762513_XZ_2.xyz), _Property_904071D7_Out_0, _NormalStrength_F54F97E9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalBlend_2EEFB9AF_Out_2;
                Unity_NormalBlend_float(_Vector3_2B1829A1_Out_0, _NormalStrength_F54F97E9_Out_2, _NormalBlend_2EEFB9AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_TriplanarNMn_059da9746584140498cd018db3c76047 _TriplanarNMn_8D3AA108;
                _TriplanarNMn_8D3AA108.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNMn_8D3AA108.WorldSpaceTangent = IN.WorldSpaceTangent;
                _TriplanarNMn_8D3AA108.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _TriplanarNMn_8D3AA108.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNMn_8D3AA108_XYZ_1;
                float4 _TriplanarNMn_8D3AA108_XZ_2;
                float4 _TriplanarNMn_8D3AA108_YZ_3;
                float4 _TriplanarNMn_8D3AA108_XY_4;
                SG_TriplanarNMn_059da9746584140498cd018db3c76047(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNMn_8D3AA108, _TriplanarNMn_8D3AA108_XYZ_1, _TriplanarNMn_8D3AA108_XZ_2, _TriplanarNMn_8D3AA108_YZ_3, _TriplanarNMn_8D3AA108_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_995C1788_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_44BA1170_Out_2;
                Unity_NormalStrength_float((_TriplanarNMn_8D3AA108_XYZ_1.xyz), _Property_995C1788_Out_0, _NormalStrength_44BA1170_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Multiply_73E49A46_Out_2;
                Unity_Multiply_float(_Property_932BDEF_Out_0, IN.WorldSpaceNormal, _Multiply_73E49A46_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_D1026BB1_R_1 = _Multiply_73E49A46_Out_2[0];
                float _Split_D1026BB1_G_2 = _Multiply_73E49A46_Out_2[1];
                float _Split_D1026BB1_B_3 = _Multiply_73E49A46_Out_2[2];
                float _Split_D1026BB1_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_CCE93C47_Out_2;
                Unity_Add_float(_Split_D1026BB1_R_1, _Split_D1026BB1_G_2, _Add_CCE93C47_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_32345D47_Out_2;
                Unity_Add_float(_Add_CCE93C47_Out_2, _Split_D1026BB1_B_3, _Add_32345D47_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B1FFAD34_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_A2FAE14F_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_4B8044E8_Out_2;
                Unity_Subtract_float(4, _Property_A2FAE14F_Out_0, _Subtract_4B8044E8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_3B4F1D3A_Out_2;
                Unity_Divide_float(_Property_B1FFAD34_Out_0, _Subtract_4B8044E8_Out_2, _Divide_3B4F1D3A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_A4429D68_Out_1;
                Unity_Absolute_float(_Divide_3B4F1D3A_Out_2, _Absolute_A4429D68_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_FB9D1710_Out_2;
                Unity_Power_float(_Absolute_A4429D68_Out_1, _Subtract_4B8044E8_Out_2, _Power_FB9D1710_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_6B3FEC4_Out_3;
                Unity_Clamp_float(_Power_FB9D1710_Out_2, 0, 2, _Clamp_6B3FEC4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_8FBF66FA_Out_2;
                Unity_Multiply_float(_Add_32345D47_Out_2, _Clamp_6B3FEC4_Out_3, _Multiply_8FBF66FA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_9292D876_Out_1;
                Unity_Saturate_float(_Multiply_8FBF66FA_Out_2, _Saturate_9292D876_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_D0BC21C_Out_3;
                Unity_Clamp_float(_Add_32345D47_Out_2, 0, 0.9999, _Clamp_D0BC21C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B34EDBFD_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_B5480478_Out_2;
                Unity_Divide_float(_Property_B34EDBFD_Out_0, 45, _Divide_B5480478_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_CBCAD7A_Out_1;
                Unity_OneMinus_float(_Divide_B5480478_Out_2, _OneMinus_CBCAD7A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_EBEF174D_Out_2;
                Unity_Subtract_float(_Clamp_D0BC21C_Out_3, _OneMinus_CBCAD7A_Out_1, _Subtract_EBEF174D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_AA8A64A3_Out_3;
                Unity_Clamp_float(_Subtract_EBEF174D_Out_2, 0, 2, _Clamp_AA8A64A3_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_BFB32493_Out_2;
                Unity_Divide_float(1, _Divide_B5480478_Out_2, _Divide_BFB32493_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_B62964B9_Out_2;
                Unity_Multiply_float(_Clamp_AA8A64A3_Out_3, _Divide_BFB32493_Out_2, _Multiply_B62964B9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_7B34ADA9_Out_1;
                Unity_Absolute_float(_Multiply_B62964B9_Out_2, _Absolute_7B34ADA9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1DD92663_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_A1FB5EA0_Out_2;
                Unity_Power_float(_Absolute_7B34ADA9_Out_1, _Property_1DD92663_Out_0, _Power_A1FB5EA0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_C4852D4_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1AFBC8B2_Out_1;
                Unity_OneMinus_float(_Property_C4852D4_Out_0, _OneMinus_1AFBC8B2_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_DC11AC84_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_DC11AC84_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_DC11AC84_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_DC11AC84_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_86148D72_Out_2;
                Unity_Add_float(_OneMinus_1AFBC8B2_Out_1, _Split_DC11AC84_G_2, _Add_86148D72_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_39BC5217_Out_2;
                Unity_Add_float(_Add_86148D72_Out_2, 1, _Add_39BC5217_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_97F72B5E_Out_3;
                Unity_Clamp_float(_Add_39BC5217_Out_2, 0, 1, _Clamp_97F72B5E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_28703D9B_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_38B3D359_Out_2;
                Unity_Add_float(_Add_86148D72_Out_2, _Property_28703D9B_Out_0, _Add_38B3D359_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_407B44D8_Out_2;
                Unity_Divide_float(_Add_38B3D359_Out_2, _Add_86148D72_Out_2, _Divide_407B44D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_789A0D0E_Out_1;
                Unity_OneMinus_float(_Divide_407B44D8_Out_2, _OneMinus_789A0D0E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_7428640F_Out_2;
                Unity_Add_float(_OneMinus_789A0D0E_Out_1, -0.5, _Add_7428640F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_9C76860B_Out_3;
                Unity_Clamp_float(_Add_7428640F_Out_2, 0, 1, _Clamp_9C76860B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F1ED053D_Out_2;
                Unity_Add_float(_Clamp_97F72B5E_Out_3, _Clamp_9C76860B_Out_3, _Add_F1ED053D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_BFC65370_Out_3;
                Unity_Clamp_float(_Add_F1ED053D_Out_2, 0, 1, _Clamp_BFC65370_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_180E431B_Out_2;
                Unity_Multiply_float(_Power_A1FB5EA0_Out_2, _Clamp_BFC65370_Out_3, _Multiply_180E431B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_C26F02DA_Out_2;
                Unity_Multiply_float(_Saturate_9292D876_Out_1, _Multiply_180E431B_Out_2, _Multiply_C26F02DA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_3522A454_Out_3;
                Unity_Lerp_float3(_NormalBlend_2EEFB9AF_Out_2, _NormalStrength_44BA1170_Out_2, (_Multiply_C26F02DA_Out_2.xxx), _Lerp_3522A454_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_14C81C91_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_14C81C91_Out_1 = normalize(mul(Transform_14C81C91_transposeTangent, _Lerp_3522A454_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Multiply_1B01DF43_Out_2;
                Unity_Multiply_float(_Property_932BDEF_Out_0, _Transform_14C81C91_Out_1, _Multiply_1B01DF43_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_A0DF36AC_R_1 = _Multiply_1B01DF43_Out_2[0];
                float _Split_A0DF36AC_G_2 = _Multiply_1B01DF43_Out_2[1];
                float _Split_A0DF36AC_B_3 = _Multiply_1B01DF43_Out_2[2];
                float _Split_A0DF36AC_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_CDFDCB4A_Out_2;
                Unity_Add_float(_Split_A0DF36AC_R_1, _Split_A0DF36AC_G_2, _Add_CDFDCB4A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D6F78AB0_Out_2;
                Unity_Add_float(_Add_CDFDCB4A_Out_2, _Split_A0DF36AC_B_3, _Add_D6F78AB0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_955E55F1_Out_2;
                Unity_Multiply_float(_Add_D6F78AB0_Out_2, _Clamp_6B3FEC4_Out_3, _Multiply_955E55F1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2AF9B3D_Out_2;
                Unity_Multiply_float(_Clamp_6B3FEC4_Out_3, _Property_1DD92663_Out_0, _Multiply_2AF9B3D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F6BB913B_Out_2;
                Unity_Multiply_float(_Multiply_2AF9B3D_Out_2, _Multiply_180E431B_Out_2, _Multiply_F6BB913B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2FBE96C8_Out_2;
                Unity_Multiply_float(_Multiply_955E55F1_Out_2, _Multiply_F6BB913B_Out_2, _Multiply_2FBE96C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea _TriplanarNM_4DA318C7;
                _TriplanarNM_4DA318C7.WorldSpaceNormal = IN.WorldSpaceNormal;
                _TriplanarNM_4DA318C7.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                float4 _TriplanarNM_4DA318C7_XYZ_1;
                float4 _TriplanarNM_4DA318C7_XZ_2;
                float4 _TriplanarNM_4DA318C7_YZ_3;
                float4 _TriplanarNM_4DA318C7_XY_4;
                SG_TriplanarNM_bc609ed95f52591469ab35dbfe0efcea(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, (_Divide_2DD66DF0_Out_2).x, _Property_F6956647_Out_0, _TriplanarNM_4DA318C7, _TriplanarNM_4DA318C7_XYZ_1, _TriplanarNM_4DA318C7_XZ_2, _TriplanarNM_4DA318C7_YZ_3, _TriplanarNM_4DA318C7_XY_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_886A1366_R_1 = _TriplanarNM_4DA318C7_XYZ_1[0];
                float _Split_886A1366_G_2 = _TriplanarNM_4DA318C7_XYZ_1[1];
                float _Split_886A1366_B_3 = _TriplanarNM_4DA318C7_XYZ_1[2];
                float _Split_886A1366_A_4 = _TriplanarNM_4DA318C7_XYZ_1[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_9F3C748A_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_38F71BFB_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_E157D4E8_Out_0 = float2(_Property_9F3C748A_Out_0, _Property_38F71BFB_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_514307DE_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_42D344B7_Out_2;
                Unity_Add_float2(_Vector2_E157D4E8_Out_0, (_Property_514307DE_Out_0.xx), _Add_42D344B7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_BD5FD283_Out_3;
                Unity_Remap_float(_Split_886A1366_B_3, float2 (0, 1), _Add_42D344B7_Out_2, _Remap_BD5FD283_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_AA9F17C9_Out_2;
                Unity_Multiply_float(_Multiply_2FBE96C8_Out_2, _Remap_BD5FD283_Out_3, _Multiply_AA9F17C9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_B5BA182F_R_1 = IN.VertexColor[0];
                float _Split_B5BA182F_G_2 = IN.VertexColor[1];
                float _Split_B5BA182F_B_3 = IN.VertexColor[2];
                float _Split_B5BA182F_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_17BF6B0_Out_2;
                Unity_Multiply_float(_Multiply_AA9F17C9_Out_2, _Split_B5BA182F_G_2, _Multiply_17BF6B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_E4AE5990_Out_1;
                Unity_Saturate_float(_Multiply_17BF6B0_Out_2, _Saturate_E4AE5990_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_80D50DF7_Out_2;
                Unity_Multiply_float(_Clamp_1734BFE5_Out_3, _Saturate_E4AE5990_Out_1, _Multiply_80D50DF7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_D675BDBA_Out_0 = _Multiply_80D50DF7_Out_2;
                #else
                float _UseDynamicCoverTStaticMaskF_D675BDBA_Out_0 = _Clamp_1734BFE5_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_62655FB2_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_3A2278B0_OutVector4_1, (_Multiply_B1CF0578_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_D675BDBA_Out_0.xxx), _Lerp_62655FB2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_9F64AEAF_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_4AEEE38_Out_2;
                Unity_Multiply_float((_Property_9F64AEAF_Out_0.xyz), _Lerp_62655FB2_Out_3, _Multiply_4AEEE38_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_1558D782_Out_1;
                Unity_OneMinus_float(_Split_B5BA182F_R_1, _OneMinus_1558D782_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_70281627_Out_3;
                Unity_Lerp_float3(_Lerp_62655FB2_Out_3, _Multiply_4AEEE38_Out_2, (_OneMinus_1558D782_Out_1.xxx), _Lerp_70281627_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_A449C527_R_1 = _PlanarNM_B8C9761A_XZ_2[0];
                float _Split_A449C527_G_2 = _PlanarNM_B8C9761A_XZ_2[1];
                float _Split_A449C527_B_3 = _PlanarNM_B8C9761A_XZ_2[2];
                float _Split_A449C527_A_4 = _PlanarNM_B8C9761A_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EDD4395E_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_70281627_Out_3;
                surface.Alpha = _Split_A449C527_A_4;
                surface.AlphaClipThreshold = _Property_EDD4395E_Out_0;
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
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float4 tangentWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
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
            
            #if defined(KEYWORD_PERMUTATION_0)
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
                output.interp04.xyzw = input.color;
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
                output.color = input.interp04.xyzw;
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
            #elif defined(KEYWORD_PERMUTATION_1)
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
                output.interp02.xyzw = input.texCoord0;
                output.interp03.xyzw = input.color;
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
                output.texCoord0 = input.interp02.xyzw;
                output.color = input.interp03.xyzw;
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
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceNormal =           input.normalOS;
            #endif
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpaceTangent =          input.tangentOS;
            #endif
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ObjectSpacePosition =         input.positionOS;
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0)
            // use bitangent on the fly like in hdrp
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
            #endif
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0)
            // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            // This is explained in section 2.2 in "surface gradient based bump mapping framework"
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            output.WorldSpaceBiTangent =         renormFactor*bitang;
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
    CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
