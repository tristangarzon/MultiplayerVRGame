Shader "NatureManufacture/URP/Lit/Top Cover"
{
    Properties
    {
        _AlphaCutoff("Alpha Cutoff", Range(0, 1)) = 0
        _BaseColor("Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_BaseColorMap("Base Map", 2D) = "white" {}
        [ToggleUI]_BaseUsePlanarUV("Base Use Planar UV", Float) = 0
        _BaseTilingOffset("Base Tiling and Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_BaseNormalMap("Base Normal Map", 2D) = "white" {}
        _BaseNormalScale("Base Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_BaseMaskMap("Base Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
        _BaseMetallic("Base Metallic", Range(0, 1)) = 1
        _BaseAORemapMin("Base AO Remap Min", Range(0, 1)) = 0
        _BaseAORemapMax("Base AO Remap Max", Range(0, 1)) = 1
        _BaseSmoothnessRemapMin("Base Smoothness Remap Min", Range(0, 1)) = 0
        _BaseSmoothnessRemapMax("Base Smoothness Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_CoverMaskA("Cover Mask (A)", 2D) = "white" {}
        _CoverMaskPower("Cover Mask Power", Range(0, 10)) = 1
        _Cover_Amount("Cover Amount", Range(0, 2)) = 2
        _Cover_Amount_Grow_Speed("Cover Amount Grow Speed", Range(0, 3)) = 3
        _Cover_Max_Angle("Cover Max Angle", Range(0.001, 90)) = 35
        _Cover_Min_Height("Cover Min Height", Float) = -10000
        _Cover_Min_Height_Blending("Cover Min Height Blending", Range(0, 500)) = 1
        _CoverBaseColor("Cover Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_CoverBaseColorMap("Cover Base Map", 2D) = "white" {}
        [ToggleUI]_CoverUsePlanarUV("Cover Use Planar UV", Float) = 1
        _CoverTilingOffset("Cover Tiling Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_CoverNormalMap("Cover Normal Map", 2D) = "white" {}
        _CoverNormalScale("Cover Normal Scale", Range(0, 8)) = 1
        _CoverNormalBlendHardness("Cover Normal Blend Hardness", Range(0, 8)) = 1
        _CoverHardness("Cover Hardness", Range(0, 10)) = 5
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
            float _BaseNormalScale;
            float _BaseMetallic;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
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
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_8AEB0D9D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D5922584_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
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
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
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
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E1EA6E56;
                float3 _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E1EA6E56, _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
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
                float4 _Property_D4D1ED47_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_32F61C5C_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2B81B7D6;
                _PlanarNM_2B81B7D6.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2B81B7D6.uv0 = IN.uv0;
                float4 _PlanarNM_2B81B7D6_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNM_2B81B7D6, _PlanarNM_2B81B7D6_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_55050202_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_FAA2BB0D_Out_2;
                Unity_Multiply_float(_PlanarNM_2B81B7D6_XZ_2, _Property_55050202_Out_0, _Multiply_FAA2BB0D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_185DA6A6_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_FBE1466A_R_1 = _Property_185DA6A6_Out_0[0];
                float _Split_FBE1466A_G_2 = _Property_185DA6A6_Out_0[1];
                float _Split_FBE1466A_B_3 = _Property_185DA6A6_Out_0[2];
                float _Split_FBE1466A_A_4 = _Property_185DA6A6_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_660A707_Out_0 = float2(_Split_FBE1466A_R_1, _Split_FBE1466A_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_2F7FE559_Out_0 = float2(_Split_FBE1466A_B_3, _Split_FBE1466A_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_DFA3F3E4_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_660A707_Out_0, _Vector2_2F7FE559_Out_0, _TilingAndOffset_DFA3F3E4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_8AEB0D9D_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_DFA3F3E4_Out_3);
                float _SampleTexture2D_8AEB0D9D_R_4 = _SampleTexture2D_8AEB0D9D_RGBA_0.r;
                float _SampleTexture2D_8AEB0D9D_G_5 = _SampleTexture2D_8AEB0D9D_RGBA_0.g;
                float _SampleTexture2D_8AEB0D9D_B_6 = _SampleTexture2D_8AEB0D9D_RGBA_0.b;
                float _SampleTexture2D_8AEB0D9D_A_7 = _SampleTexture2D_8AEB0D9D_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_A64FC943_Out_2;
                Unity_Multiply_float(_SampleTexture2D_8AEB0D9D_R_4, 2, _Multiply_A64FC943_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_8D09FB55_Out_2;
                Unity_Add_float(_Multiply_A64FC943_Out_2, -1, _Add_8D09FB55_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6F7C9F70_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_8DDF8FBF_Out_2;
                Unity_Multiply_float(_Add_8D09FB55_Out_2, _Property_6F7C9F70_Out_0, _Multiply_8DDF8FBF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_40203200_Out_1;
                Unity_Saturate_float(_Multiply_8DDF8FBF_Out_2, _Saturate_40203200_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_7B0CA0BA_Out_1;
                Unity_Absolute_float(_Saturate_40203200_Out_1, _Absolute_7B0CA0BA_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_55BF1AC2;
                float3 _BlendOverlayBaseColor_55BF1AC2_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_FAA2BB0D_Out_2, _Add_8D09FB55_Out_2, _Absolute_7B0CA0BA_Out_1, _BlendOverlayBaseColor_55BF1AC2, _BlendOverlayBaseColor_55BF1AC2_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_7DAB730A_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_70C98109_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_555DEA41;
                _PlanarNM_555DEA41.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_555DEA41.uv0 = IN.uv0;
                float4 _PlanarNM_555DEA41_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNM_555DEA41, _PlanarNM_555DEA41_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_746EB831_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_E963B30_Out_2;
                Unity_Multiply_float(_PlanarNM_555DEA41_XZ_2, _Property_746EB831_Out_0, _Multiply_E963B30_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_B578532A_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_D5922584_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_B578532A_Out_0.xy));
                float _SampleTexture2D_D5922584_R_4 = _SampleTexture2D_D5922584_RGBA_0.r;
                float _SampleTexture2D_D5922584_G_5 = _SampleTexture2D_D5922584_RGBA_0.g;
                float _SampleTexture2D_D5922584_B_6 = _SampleTexture2D_D5922584_RGBA_0.b;
                float _SampleTexture2D_D5922584_A_7 = _SampleTexture2D_D5922584_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_B66134FE_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_A77851BF_Out_2;
                Unity_Multiply_float(_SampleTexture2D_D5922584_A_7, _Property_B66134FE_Out_0, _Multiply_A77851BF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_C182A13B_Out_3;
                Unity_Clamp_float(_Multiply_A77851BF_Out_2, 0, 1, _Clamp_C182A13B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_B448FD28_R_1 = IN.VertexColor[0];
                float _Split_B448FD28_G_2 = IN.VertexColor[1];
                float _Split_B448FD28_B_3 = IN.VertexColor[2];
                float _Split_B448FD28_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_49FC42EC_Out_0 = float2(_SampleTexture2D_8AEB0D9D_A_7, _SampleTexture2D_8AEB0D9D_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Multiply_71EE890B_Out_2;
                Unity_Multiply_float(_Vector2_49FC42EC_Out_0, float2(2, 2), _Multiply_71EE890B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_479AB869_Out_2;
                Unity_Add_float2(_Multiply_71EE890B_Out_2, float2(-1, -1), _Add_479AB869_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_CB2C500_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Multiply_C04FAABC_Out_2;
                Unity_Multiply_float(_Add_479AB869_Out_2, (_Property_CB2C500_Out_0.xx), _Multiply_C04FAABC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_BD18AABD_R_1 = _Multiply_C04FAABC_Out_2[0];
                float _Split_BD18AABD_G_2 = _Multiply_C04FAABC_Out_2[1];
                float _Split_BD18AABD_B_3 = 0;
                float _Split_BD18AABD_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _DotProduct_F55479F2_Out_2;
                Unity_DotProduct_float2(_Multiply_C04FAABC_Out_2, _Multiply_C04FAABC_Out_2, _DotProduct_F55479F2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_16F1DB17_Out_1;
                Unity_Saturate_float(_DotProduct_F55479F2_Out_2, _Saturate_16F1DB17_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_2E8C65BE_Out_1;
                Unity_OneMinus_float(_Saturate_16F1DB17_Out_1, _OneMinus_2E8C65BE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _SquareRoot_A1EE594A_Out_1;
                Unity_SquareRoot_float(_OneMinus_2E8C65BE_Out_1, _SquareRoot_A1EE594A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_64C27CDB_Out_0 = float3(_Split_BD18AABD_R_1, _Split_BD18AABD_G_2, _SquareRoot_A1EE594A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_2E82066A;
                _PlanarNMn_2E82066A.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_2E82066A.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_2E82066A.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_2E82066A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_2E82066A.uv0 = IN.uv0;
                float4 _PlanarNMn_2E82066A_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNMn_2E82066A, _PlanarNMn_2E82066A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_197D10B2_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_3739AC6A_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_2E82066A_XZ_2.xyz), _Property_197D10B2_Out_0, _NormalStrength_3739AC6A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalBlend_9FB995E_Out_2;
                Unity_NormalBlend_float(_Vector3_64C27CDB_Out_0, _NormalStrength_3739AC6A_Out_2, _NormalBlend_9FB995E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_F09F2626;
                _PlanarNMn_F09F2626.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_F09F2626.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_F09F2626.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_F09F2626.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_F09F2626.uv0 = IN.uv0;
                float4 _PlanarNMn_F09F2626_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNMn_F09F2626, _PlanarNMn_F09F2626_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_8EB6D07F_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_651E468F_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_F09F2626_XZ_2.xyz), _Property_8EB6D07F_Out_0, _NormalStrength_651E468F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_13A85D2C_R_1 = IN.WorldSpaceNormal[0];
                float _Split_13A85D2C_G_2 = IN.WorldSpaceNormal[1];
                float _Split_13A85D2C_B_3 = IN.WorldSpaceNormal[2];
                float _Split_13A85D2C_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7335D6FA_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_ACA0CF6E_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_56C48BF2_Out_2;
                Unity_Subtract_float(4, _Property_ACA0CF6E_Out_0, _Subtract_56C48BF2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_3C1B250C_Out_2;
                Unity_Divide_float(_Property_7335D6FA_Out_0, _Subtract_56C48BF2_Out_2, _Divide_3C1B250C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_418CF584_Out_1;
                Unity_Absolute_float(_Divide_3C1B250C_Out_2, _Absolute_418CF584_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_B95C2CD8_Out_2;
                Unity_Power_float(_Absolute_418CF584_Out_1, _Subtract_56C48BF2_Out_2, _Power_B95C2CD8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_5D011C95_Out_3;
                Unity_Clamp_float(_Power_B95C2CD8_Out_2, 0, 2, _Clamp_5D011C95_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2639178A_Out_2;
                Unity_Multiply_float(_Split_13A85D2C_G_2, _Clamp_5D011C95_Out_3, _Multiply_2639178A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_71FE7D8D_Out_1;
                Unity_Saturate_float(_Multiply_2639178A_Out_2, _Saturate_71FE7D8D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_DDC6BC83_Out_3;
                Unity_Clamp_float(_Split_13A85D2C_G_2, 0, 0.9999, _Clamp_DDC6BC83_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1C09E3E3_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_CA17F432_Out_2;
                Unity_Divide_float(_Property_1C09E3E3_Out_0, 45, _Divide_CA17F432_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_9F8CA044_Out_1;
                Unity_OneMinus_float(_Divide_CA17F432_Out_2, _OneMinus_9F8CA044_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_375F1241_Out_2;
                Unity_Subtract_float(_Clamp_DDC6BC83_Out_3, _OneMinus_9F8CA044_Out_1, _Subtract_375F1241_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_B4ABAE50_Out_3;
                Unity_Clamp_float(_Subtract_375F1241_Out_2, 0, 2, _Clamp_B4ABAE50_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_6DAADCFF_Out_2;
                Unity_Divide_float(1, _Divide_CA17F432_Out_2, _Divide_6DAADCFF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5664838C_Out_2;
                Unity_Multiply_float(_Clamp_B4ABAE50_Out_3, _Divide_6DAADCFF_Out_2, _Multiply_5664838C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_BEC83B5_Out_1;
                Unity_Absolute_float(_Multiply_5664838C_Out_2, _Absolute_BEC83B5_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7EA17782_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_5A144FE_Out_2;
                Unity_Power_float(_Absolute_BEC83B5_Out_1, _Property_7EA17782_Out_0, _Power_5A144FE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_488913EE_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1AF0460E_Out_1;
                Unity_OneMinus_float(_Property_488913EE_Out_0, _OneMinus_1AF0460E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_34217464_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34217464_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34217464_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34217464_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D91B7DB4_Out_2;
                Unity_Add_float(_OneMinus_1AF0460E_Out_1, _Split_34217464_G_2, _Add_D91B7DB4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D26FB8B9_Out_2;
                Unity_Add_float(_Add_D91B7DB4_Out_2, 1, _Add_D26FB8B9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_576A24A0_Out_3;
                Unity_Clamp_float(_Add_D26FB8B9_Out_2, 0, 1, _Clamp_576A24A0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7616F871_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DF03E9C4_Out_2;
                Unity_Add_float(_Add_D91B7DB4_Out_2, _Property_7616F871_Out_0, _Add_DF03E9C4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_203EE78E_Out_2;
                Unity_Divide_float(_Add_DF03E9C4_Out_2, _Add_D91B7DB4_Out_2, _Divide_203EE78E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_516ABAA3_Out_1;
                Unity_OneMinus_float(_Divide_203EE78E_Out_2, _OneMinus_516ABAA3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F150E343_Out_2;
                Unity_Add_float(_OneMinus_516ABAA3_Out_1, -0.5, _Add_F150E343_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_70010EDF_Out_3;
                Unity_Clamp_float(_Add_F150E343_Out_2, 0, 1, _Clamp_70010EDF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F92F5732_Out_2;
                Unity_Add_float(_Clamp_576A24A0_Out_3, _Clamp_70010EDF_Out_3, _Add_F92F5732_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_3DD32DC1_Out_3;
                Unity_Clamp_float(_Add_F92F5732_Out_2, 0, 1, _Clamp_3DD32DC1_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D6F10F20_Out_2;
                Unity_Multiply_float(_Power_5A144FE_Out_2, _Clamp_3DD32DC1_Out_3, _Multiply_D6F10F20_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_E033E66D_Out_2;
                Unity_Multiply_float(_Saturate_71FE7D8D_Out_1, _Multiply_D6F10F20_Out_2, _Multiply_E033E66D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_C13A552C_Out_3;
                Unity_Lerp_float3(_NormalBlend_9FB995E_Out_2, _NormalStrength_651E468F_Out_2, (_Multiply_E033E66D_Out_2.xxx), _Lerp_C13A552C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_E9DA5BB7_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_E9DA5BB7_Out_1 = normalize(mul(Transform_E9DA5BB7_transposeTangent, _Lerp_C13A552C_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_7BBB0748_R_1 = _Transform_E9DA5BB7_Out_1[0];
                float _Split_7BBB0748_G_2 = _Transform_E9DA5BB7_Out_1[1];
                float _Split_7BBB0748_B_3 = _Transform_E9DA5BB7_Out_1[2];
                float _Split_7BBB0748_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_727F09BD_Out_2;
                Unity_Multiply_float(_Split_7BBB0748_G_2, _Clamp_5D011C95_Out_3, _Multiply_727F09BD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_46F6187F_Out_2;
                Unity_Multiply_float(_Clamp_5D011C95_Out_3, _Property_7EA17782_Out_0, _Multiply_46F6187F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_95DA832F_Out_2;
                Unity_Multiply_float(_Multiply_46F6187F_Out_2, _Multiply_D6F10F20_Out_2, _Multiply_95DA832F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_BA3245FD_Out_2;
                Unity_Multiply_float(_Multiply_727F09BD_Out_2, _Multiply_95DA832F_Out_2, _Multiply_BA3245FD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_644BF3FC;
                _PlanarNM_644BF3FC.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_644BF3FC.uv0 = IN.uv0;
                float4 _PlanarNM_644BF3FC_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNM_644BF3FC, _PlanarNM_644BF3FC_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_CD01958C_R_1 = _PlanarNM_644BF3FC_XZ_2[0];
                float _Split_CD01958C_G_2 = _PlanarNM_644BF3FC_XZ_2[1];
                float _Split_CD01958C_B_3 = _PlanarNM_644BF3FC_XZ_2[2];
                float _Split_CD01958C_A_4 = _PlanarNM_644BF3FC_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_8CF0D98_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B62E4368_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_2D0066D3_Out_0 = float2(_Property_8CF0D98_Out_0, _Property_B62E4368_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B3096413_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_DD0E7210_Out_2;
                Unity_Add_float2(_Vector2_2D0066D3_Out_0, (_Property_B3096413_Out_0.xx), _Add_DD0E7210_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_6BAAF88A_Out_3;
                Unity_Remap_float(_Split_CD01958C_B_3, float2 (0, 1), _Add_DD0E7210_Out_2, _Remap_6BAAF88A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_BFE93ACB_Out_2;
                Unity_Multiply_float(_Multiply_BA3245FD_Out_2, _Remap_6BAAF88A_Out_3, _Multiply_BFE93ACB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D85587E1_Out_2;
                Unity_Multiply_float(_Split_B448FD28_G_2, _Multiply_BFE93ACB_Out_2, _Multiply_D85587E1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_1BD2E7C3_Out_1;
                Unity_Saturate_float(_Multiply_D85587E1_Out_2, _Saturate_1BD2E7C3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_6F17250E_Out_2;
                Unity_Multiply_float(_Clamp_C182A13B_Out_3, _Saturate_1BD2E7C3_Out_1, _Multiply_6F17250E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A3223D36_Out_3;
                Unity_Clamp_float(_Multiply_6F17250E_Out_2, 0, 1, _Clamp_A3223D36_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_33C9D57A_Out_0 = _Clamp_A3223D36_Out_3;
                #else
                float _UseDynamicCoverTStaticMaskF_33C9D57A_Out_0 = _Clamp_C182A13B_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_11D84EE9_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_55BF1AC2_OutVector4_1, (_Multiply_E963B30_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_33C9D57A_Out_0.xxx), _Lerp_11D84EE9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_DCA3E424_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_6067A678_Out_2;
                Unity_Multiply_float((_Property_DCA3E424_Out_0.xyz), _Lerp_11D84EE9_Out_3, _Multiply_6067A678_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_61228C0A_Out_1;
                Unity_OneMinus_float(_Split_B448FD28_R_1, _OneMinus_61228C0A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_F40C1057_Out_3;
                Unity_Lerp_float3(_Lerp_11D84EE9_Out_3, _Multiply_6067A678_Out_2, (_OneMinus_61228C0A_Out_1.xxx), _Lerp_F40C1057_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_555AD002_Out_0 = _CoverNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_9E38E2D4_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_F09F2626_XZ_2.xyz), _Property_555AD002_Out_0, _NormalStrength_9E38E2D4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_3BC129ED_Out_3;
                Unity_Lerp_float3(_NormalBlend_9FB995E_Out_2, _NormalStrength_9E38E2D4_Out_2, (_UseDynamicCoverTStaticMaskF_33C9D57A_Out_0.xxx), _Lerp_3BC129ED_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_AA36EE7C;
                _PlanarNM_AA36EE7C.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_AA36EE7C.uv0 = IN.uv0;
                float4 _PlanarNM_AA36EE7C_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNM_AA36EE7C, _PlanarNM_AA36EE7C_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_690E0730_R_1 = _PlanarNM_AA36EE7C_XZ_2[0];
                float _Split_690E0730_G_2 = _PlanarNM_AA36EE7C_XZ_2[1];
                float _Split_690E0730_B_3 = _PlanarNM_AA36EE7C_XZ_2[2];
                float _Split_690E0730_A_4 = _PlanarNM_AA36EE7C_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_93595467_Out_0 = _BaseMetallic;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_ED9EB6E1_Out_2;
                Unity_Multiply_float(_Split_690E0730_R_1, _Property_93595467_Out_0, _Multiply_ED9EB6E1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_55D3ECA7_Out_0 = _BaseAORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_5D87DB97_Out_0 = _BaseAORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_8D08205F_Out_0 = float2(_Property_55D3ECA7_Out_0, _Property_5D87DB97_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_2D28D06A_Out_3;
                Unity_Remap_float(_Split_690E0730_G_2, float2 (0, 1), _Vector2_8D08205F_Out_0, _Remap_2D28D06A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F50FCF72_Out_0 = _BaseSmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_21A8B440_Out_0 = _BaseSmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_964F16F5_Out_0 = float2(_Property_F50FCF72_Out_0, _Property_21A8B440_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_F30DDD6C_Out_3;
                Unity_Remap_float(_Split_690E0730_A_4, float2 (0, 1), _Vector2_964F16F5_Out_0, _Remap_F30DDD6C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_8810E555_Out_2;
                Unity_Multiply_float(_SampleTexture2D_8AEB0D9D_B_6, 2, _Multiply_8810E555_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_202AFD49_Out_2;
                Unity_Add_float(_Multiply_8810E555_Out_2, -1, _Add_202AFD49_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_F168027A_Out_0 = _DetailSmoothnessScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_4E65680A_Out_2;
                Unity_Multiply_float(_Add_202AFD49_Out_2, _Property_F168027A_Out_0, _Multiply_4E65680A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_F4FEA502_Out_1;
                Unity_Saturate_float(_Multiply_4E65680A_Out_2, _Saturate_F4FEA502_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_380EE6A_Out_1;
                Unity_Absolute_float(_Saturate_F4FEA502_Out_1, _Absolute_380EE6A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a _BlendOverlayDetailSmoothness_8284B3CD;
                float _BlendOverlayDetailSmoothness_8284B3CD_SmoothnessOverlay_1;
                SG_BlendOverlayDetailSmoothness_06e12138dc89c0040b45a57abe520a1a(_Remap_F30DDD6C_Out_3, _Add_202AFD49_Out_2, _Absolute_380EE6A_Out_1, _BlendOverlayDetailSmoothness_8284B3CD, _BlendOverlayDetailSmoothness_8284B3CD_SmoothnessOverlay_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_CA8D61D9_Out_1;
                Unity_Saturate_float(_BlendOverlayDetailSmoothness_8284B3CD_SmoothnessOverlay_1, _Saturate_CA8D61D9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_E18ED55D_Out_0 = float3(_Multiply_ED9EB6E1_Out_2, _Remap_2D28D06A_Out_3, _Saturate_CA8D61D9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_89E3E963_Out_0 = _CoverMetallic;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_EEFBDC8B_Out_2;
                Unity_Multiply_float(_Split_CD01958C_R_1, _Property_89E3E963_Out_0, _Multiply_EEFBDC8B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_43D7066B_Out_0 = _CoverAORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C92B5101_Out_0 = _CoverAORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_D64F5CB1_Out_0 = float2(_Property_43D7066B_Out_0, _Property_C92B5101_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_7A6102DC_Out_3;
                Unity_Remap_float(_Split_CD01958C_G_2, float2 (0, 1), _Vector2_D64F5CB1_Out_0, _Remap_7A6102DC_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_90EBC28_Out_0 = _CoverSmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_D394C3E9_Out_0 = _CoverSmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_252C7919_Out_0 = float2(_Property_90EBC28_Out_0, _Property_D394C3E9_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_55BFDE23_Out_3;
                Unity_Remap_float(_Split_CD01958C_A_4, float2 (0, 1), _Vector2_252C7919_Out_0, _Remap_55BFDE23_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_4B060013_Out_0 = float3(_Multiply_EEFBDC8B_Out_2, _Remap_7A6102DC_Out_3, _Remap_55BFDE23_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_ED3D0381_Out_3;
                Unity_Lerp_float3(_Vector3_E18ED55D_Out_0, _Vector3_4B060013_Out_0, (_UseDynamicCoverTStaticMaskF_33C9D57A_Out_0.xxx), _Lerp_ED3D0381_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_E43CD03E_R_1 = _Lerp_ED3D0381_Out_3[0];
                float _Split_E43CD03E_G_2 = _Lerp_ED3D0381_Out_3[1];
                float _Split_E43CD03E_B_3 = _Lerp_ED3D0381_Out_3[2];
                float _Split_E43CD03E_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C5C839A2_Out_0 = _WetSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_CC450684_Out_3;
                Unity_Lerp_float(_Split_E43CD03E_B_3, _Property_C5C839A2_Out_0, _OneMinus_61228C0A_Out_1, _Lerp_CC450684_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9CE54B68_R_1 = _PlanarNM_2B81B7D6_XZ_2[0];
                float _Split_9CE54B68_G_2 = _PlanarNM_2B81B7D6_XZ_2[1];
                float _Split_9CE54B68_B_3 = _PlanarNM_2B81B7D6_XZ_2[2];
                float _Split_9CE54B68_A_4 = _PlanarNM_2B81B7D6_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4BAFEB7E_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_F40C1057_Out_3;
                surface.Normal = _Lerp_3BC129ED_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Metallic = _Split_E43CD03E_R_1;
                surface.Smoothness = _Lerp_CC450684_Out_3;
                surface.Occlusion = _Split_E43CD03E_G_2;
                surface.Alpha = _Split_9CE54B68_A_4;
                surface.AlphaClipThreshold = _Property_4BAFEB7E_Out_0;
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
            float _BaseNormalScale;
            float _BaseMetallic;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
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
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E1EA6E56;
                float3 _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E1EA6E56, _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
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
                float4 _Property_D4D1ED47_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_32F61C5C_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2B81B7D6;
                _PlanarNM_2B81B7D6.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2B81B7D6.uv0 = IN.uv0;
                float4 _PlanarNM_2B81B7D6_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNM_2B81B7D6, _PlanarNM_2B81B7D6_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9CE54B68_R_1 = _PlanarNM_2B81B7D6_XZ_2[0];
                float _Split_9CE54B68_G_2 = _PlanarNM_2B81B7D6_XZ_2[1];
                float _Split_9CE54B68_B_3 = _PlanarNM_2B81B7D6_XZ_2[2];
                float _Split_9CE54B68_A_4 = _PlanarNM_2B81B7D6_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4BAFEB7E_Out_0 = _AlphaCutoff;
                #endif
                surface.Alpha = _Split_9CE54B68_A_4;
                surface.AlphaClipThreshold = _Property_4BAFEB7E_Out_0;
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
            float _BaseNormalScale;
            float _BaseMetallic;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
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
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E1EA6E56;
                float3 _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E1EA6E56, _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
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
                float4 _Property_D4D1ED47_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_32F61C5C_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2B81B7D6;
                _PlanarNM_2B81B7D6.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2B81B7D6.uv0 = IN.uv0;
                float4 _PlanarNM_2B81B7D6_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNM_2B81B7D6, _PlanarNM_2B81B7D6_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9CE54B68_R_1 = _PlanarNM_2B81B7D6_XZ_2[0];
                float _Split_9CE54B68_G_2 = _PlanarNM_2B81B7D6_XZ_2[1];
                float _Split_9CE54B68_B_3 = _PlanarNM_2B81B7D6_XZ_2[2];
                float _Split_9CE54B68_A_4 = _PlanarNM_2B81B7D6_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4BAFEB7E_Out_0 = _AlphaCutoff;
                #endif
                surface.Alpha = _Split_9CE54B68_A_4;
                surface.AlphaClipThreshold = _Property_4BAFEB7E_Out_0;
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
        
        #if defined(KEYWORD_PERMUTATION_0)
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
            float _BaseNormalScale;
            float _BaseMetallic;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
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
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_8AEB0D9D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D5922584_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
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
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
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
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E1EA6E56;
                float3 _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E1EA6E56, _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0)
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
                float4 _Property_D4D1ED47_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_32F61C5C_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2B81B7D6;
                _PlanarNM_2B81B7D6.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2B81B7D6.uv0 = IN.uv0;
                float4 _PlanarNM_2B81B7D6_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNM_2B81B7D6, _PlanarNM_2B81B7D6_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_55050202_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_FAA2BB0D_Out_2;
                Unity_Multiply_float(_PlanarNM_2B81B7D6_XZ_2, _Property_55050202_Out_0, _Multiply_FAA2BB0D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_185DA6A6_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_FBE1466A_R_1 = _Property_185DA6A6_Out_0[0];
                float _Split_FBE1466A_G_2 = _Property_185DA6A6_Out_0[1];
                float _Split_FBE1466A_B_3 = _Property_185DA6A6_Out_0[2];
                float _Split_FBE1466A_A_4 = _Property_185DA6A6_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_660A707_Out_0 = float2(_Split_FBE1466A_R_1, _Split_FBE1466A_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_2F7FE559_Out_0 = float2(_Split_FBE1466A_B_3, _Split_FBE1466A_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_DFA3F3E4_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_660A707_Out_0, _Vector2_2F7FE559_Out_0, _TilingAndOffset_DFA3F3E4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_8AEB0D9D_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_DFA3F3E4_Out_3);
                float _SampleTexture2D_8AEB0D9D_R_4 = _SampleTexture2D_8AEB0D9D_RGBA_0.r;
                float _SampleTexture2D_8AEB0D9D_G_5 = _SampleTexture2D_8AEB0D9D_RGBA_0.g;
                float _SampleTexture2D_8AEB0D9D_B_6 = _SampleTexture2D_8AEB0D9D_RGBA_0.b;
                float _SampleTexture2D_8AEB0D9D_A_7 = _SampleTexture2D_8AEB0D9D_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_A64FC943_Out_2;
                Unity_Multiply_float(_SampleTexture2D_8AEB0D9D_R_4, 2, _Multiply_A64FC943_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_8D09FB55_Out_2;
                Unity_Add_float(_Multiply_A64FC943_Out_2, -1, _Add_8D09FB55_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6F7C9F70_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_8DDF8FBF_Out_2;
                Unity_Multiply_float(_Add_8D09FB55_Out_2, _Property_6F7C9F70_Out_0, _Multiply_8DDF8FBF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_40203200_Out_1;
                Unity_Saturate_float(_Multiply_8DDF8FBF_Out_2, _Saturate_40203200_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_7B0CA0BA_Out_1;
                Unity_Absolute_float(_Saturate_40203200_Out_1, _Absolute_7B0CA0BA_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_55BF1AC2;
                float3 _BlendOverlayBaseColor_55BF1AC2_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_FAA2BB0D_Out_2, _Add_8D09FB55_Out_2, _Absolute_7B0CA0BA_Out_1, _BlendOverlayBaseColor_55BF1AC2, _BlendOverlayBaseColor_55BF1AC2_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_7DAB730A_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_70C98109_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_555DEA41;
                _PlanarNM_555DEA41.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_555DEA41.uv0 = IN.uv0;
                float4 _PlanarNM_555DEA41_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNM_555DEA41, _PlanarNM_555DEA41_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_746EB831_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_E963B30_Out_2;
                Unity_Multiply_float(_PlanarNM_555DEA41_XZ_2, _Property_746EB831_Out_0, _Multiply_E963B30_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_B578532A_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_D5922584_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_B578532A_Out_0.xy));
                float _SampleTexture2D_D5922584_R_4 = _SampleTexture2D_D5922584_RGBA_0.r;
                float _SampleTexture2D_D5922584_G_5 = _SampleTexture2D_D5922584_RGBA_0.g;
                float _SampleTexture2D_D5922584_B_6 = _SampleTexture2D_D5922584_RGBA_0.b;
                float _SampleTexture2D_D5922584_A_7 = _SampleTexture2D_D5922584_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_B66134FE_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_A77851BF_Out_2;
                Unity_Multiply_float(_SampleTexture2D_D5922584_A_7, _Property_B66134FE_Out_0, _Multiply_A77851BF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_C182A13B_Out_3;
                Unity_Clamp_float(_Multiply_A77851BF_Out_2, 0, 1, _Clamp_C182A13B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_B448FD28_R_1 = IN.VertexColor[0];
                float _Split_B448FD28_G_2 = IN.VertexColor[1];
                float _Split_B448FD28_B_3 = IN.VertexColor[2];
                float _Split_B448FD28_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_49FC42EC_Out_0 = float2(_SampleTexture2D_8AEB0D9D_A_7, _SampleTexture2D_8AEB0D9D_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_71EE890B_Out_2;
                Unity_Multiply_float(_Vector2_49FC42EC_Out_0, float2(2, 2), _Multiply_71EE890B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_479AB869_Out_2;
                Unity_Add_float2(_Multiply_71EE890B_Out_2, float2(-1, -1), _Add_479AB869_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_CB2C500_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_C04FAABC_Out_2;
                Unity_Multiply_float(_Add_479AB869_Out_2, (_Property_CB2C500_Out_0.xx), _Multiply_C04FAABC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_BD18AABD_R_1 = _Multiply_C04FAABC_Out_2[0];
                float _Split_BD18AABD_G_2 = _Multiply_C04FAABC_Out_2[1];
                float _Split_BD18AABD_B_3 = 0;
                float _Split_BD18AABD_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _DotProduct_F55479F2_Out_2;
                Unity_DotProduct_float2(_Multiply_C04FAABC_Out_2, _Multiply_C04FAABC_Out_2, _DotProduct_F55479F2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_16F1DB17_Out_1;
                Unity_Saturate_float(_DotProduct_F55479F2_Out_2, _Saturate_16F1DB17_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_2E8C65BE_Out_1;
                Unity_OneMinus_float(_Saturate_16F1DB17_Out_1, _OneMinus_2E8C65BE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _SquareRoot_A1EE594A_Out_1;
                Unity_SquareRoot_float(_OneMinus_2E8C65BE_Out_1, _SquareRoot_A1EE594A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Vector3_64C27CDB_Out_0 = float3(_Split_BD18AABD_R_1, _Split_BD18AABD_G_2, _SquareRoot_A1EE594A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_2E82066A;
                _PlanarNMn_2E82066A.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_2E82066A.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_2E82066A.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_2E82066A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_2E82066A.uv0 = IN.uv0;
                float4 _PlanarNMn_2E82066A_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNMn_2E82066A, _PlanarNMn_2E82066A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_197D10B2_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_3739AC6A_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_2E82066A_XZ_2.xyz), _Property_197D10B2_Out_0, _NormalStrength_3739AC6A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalBlend_9FB995E_Out_2;
                Unity_NormalBlend_float(_Vector3_64C27CDB_Out_0, _NormalStrength_3739AC6A_Out_2, _NormalBlend_9FB995E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_F09F2626;
                _PlanarNMn_F09F2626.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_F09F2626.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_F09F2626.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_F09F2626.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_F09F2626.uv0 = IN.uv0;
                float4 _PlanarNMn_F09F2626_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNMn_F09F2626, _PlanarNMn_F09F2626_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_8EB6D07F_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_651E468F_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_F09F2626_XZ_2.xyz), _Property_8EB6D07F_Out_0, _NormalStrength_651E468F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_13A85D2C_R_1 = IN.WorldSpaceNormal[0];
                float _Split_13A85D2C_G_2 = IN.WorldSpaceNormal[1];
                float _Split_13A85D2C_B_3 = IN.WorldSpaceNormal[2];
                float _Split_13A85D2C_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7335D6FA_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_ACA0CF6E_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_56C48BF2_Out_2;
                Unity_Subtract_float(4, _Property_ACA0CF6E_Out_0, _Subtract_56C48BF2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_3C1B250C_Out_2;
                Unity_Divide_float(_Property_7335D6FA_Out_0, _Subtract_56C48BF2_Out_2, _Divide_3C1B250C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_418CF584_Out_1;
                Unity_Absolute_float(_Divide_3C1B250C_Out_2, _Absolute_418CF584_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_B95C2CD8_Out_2;
                Unity_Power_float(_Absolute_418CF584_Out_1, _Subtract_56C48BF2_Out_2, _Power_B95C2CD8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_5D011C95_Out_3;
                Unity_Clamp_float(_Power_B95C2CD8_Out_2, 0, 2, _Clamp_5D011C95_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2639178A_Out_2;
                Unity_Multiply_float(_Split_13A85D2C_G_2, _Clamp_5D011C95_Out_3, _Multiply_2639178A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_71FE7D8D_Out_1;
                Unity_Saturate_float(_Multiply_2639178A_Out_2, _Saturate_71FE7D8D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_DDC6BC83_Out_3;
                Unity_Clamp_float(_Split_13A85D2C_G_2, 0, 0.9999, _Clamp_DDC6BC83_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1C09E3E3_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_CA17F432_Out_2;
                Unity_Divide_float(_Property_1C09E3E3_Out_0, 45, _Divide_CA17F432_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_9F8CA044_Out_1;
                Unity_OneMinus_float(_Divide_CA17F432_Out_2, _OneMinus_9F8CA044_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_375F1241_Out_2;
                Unity_Subtract_float(_Clamp_DDC6BC83_Out_3, _OneMinus_9F8CA044_Out_1, _Subtract_375F1241_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_B4ABAE50_Out_3;
                Unity_Clamp_float(_Subtract_375F1241_Out_2, 0, 2, _Clamp_B4ABAE50_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_6DAADCFF_Out_2;
                Unity_Divide_float(1, _Divide_CA17F432_Out_2, _Divide_6DAADCFF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5664838C_Out_2;
                Unity_Multiply_float(_Clamp_B4ABAE50_Out_3, _Divide_6DAADCFF_Out_2, _Multiply_5664838C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_BEC83B5_Out_1;
                Unity_Absolute_float(_Multiply_5664838C_Out_2, _Absolute_BEC83B5_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7EA17782_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_5A144FE_Out_2;
                Unity_Power_float(_Absolute_BEC83B5_Out_1, _Property_7EA17782_Out_0, _Power_5A144FE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_488913EE_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1AF0460E_Out_1;
                Unity_OneMinus_float(_Property_488913EE_Out_0, _OneMinus_1AF0460E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_34217464_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34217464_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34217464_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34217464_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D91B7DB4_Out_2;
                Unity_Add_float(_OneMinus_1AF0460E_Out_1, _Split_34217464_G_2, _Add_D91B7DB4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D26FB8B9_Out_2;
                Unity_Add_float(_Add_D91B7DB4_Out_2, 1, _Add_D26FB8B9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_576A24A0_Out_3;
                Unity_Clamp_float(_Add_D26FB8B9_Out_2, 0, 1, _Clamp_576A24A0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7616F871_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DF03E9C4_Out_2;
                Unity_Add_float(_Add_D91B7DB4_Out_2, _Property_7616F871_Out_0, _Add_DF03E9C4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_203EE78E_Out_2;
                Unity_Divide_float(_Add_DF03E9C4_Out_2, _Add_D91B7DB4_Out_2, _Divide_203EE78E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_516ABAA3_Out_1;
                Unity_OneMinus_float(_Divide_203EE78E_Out_2, _OneMinus_516ABAA3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F150E343_Out_2;
                Unity_Add_float(_OneMinus_516ABAA3_Out_1, -0.5, _Add_F150E343_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_70010EDF_Out_3;
                Unity_Clamp_float(_Add_F150E343_Out_2, 0, 1, _Clamp_70010EDF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F92F5732_Out_2;
                Unity_Add_float(_Clamp_576A24A0_Out_3, _Clamp_70010EDF_Out_3, _Add_F92F5732_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_3DD32DC1_Out_3;
                Unity_Clamp_float(_Add_F92F5732_Out_2, 0, 1, _Clamp_3DD32DC1_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D6F10F20_Out_2;
                Unity_Multiply_float(_Power_5A144FE_Out_2, _Clamp_3DD32DC1_Out_3, _Multiply_D6F10F20_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_E033E66D_Out_2;
                Unity_Multiply_float(_Saturate_71FE7D8D_Out_1, _Multiply_D6F10F20_Out_2, _Multiply_E033E66D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_C13A552C_Out_3;
                Unity_Lerp_float3(_NormalBlend_9FB995E_Out_2, _NormalStrength_651E468F_Out_2, (_Multiply_E033E66D_Out_2.xxx), _Lerp_C13A552C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_E9DA5BB7_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_E9DA5BB7_Out_1 = normalize(mul(Transform_E9DA5BB7_transposeTangent, _Lerp_C13A552C_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_7BBB0748_R_1 = _Transform_E9DA5BB7_Out_1[0];
                float _Split_7BBB0748_G_2 = _Transform_E9DA5BB7_Out_1[1];
                float _Split_7BBB0748_B_3 = _Transform_E9DA5BB7_Out_1[2];
                float _Split_7BBB0748_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_727F09BD_Out_2;
                Unity_Multiply_float(_Split_7BBB0748_G_2, _Clamp_5D011C95_Out_3, _Multiply_727F09BD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_46F6187F_Out_2;
                Unity_Multiply_float(_Clamp_5D011C95_Out_3, _Property_7EA17782_Out_0, _Multiply_46F6187F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_95DA832F_Out_2;
                Unity_Multiply_float(_Multiply_46F6187F_Out_2, _Multiply_D6F10F20_Out_2, _Multiply_95DA832F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_BA3245FD_Out_2;
                Unity_Multiply_float(_Multiply_727F09BD_Out_2, _Multiply_95DA832F_Out_2, _Multiply_BA3245FD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_644BF3FC;
                _PlanarNM_644BF3FC.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_644BF3FC.uv0 = IN.uv0;
                float4 _PlanarNM_644BF3FC_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNM_644BF3FC, _PlanarNM_644BF3FC_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_CD01958C_R_1 = _PlanarNM_644BF3FC_XZ_2[0];
                float _Split_CD01958C_G_2 = _PlanarNM_644BF3FC_XZ_2[1];
                float _Split_CD01958C_B_3 = _PlanarNM_644BF3FC_XZ_2[2];
                float _Split_CD01958C_A_4 = _PlanarNM_644BF3FC_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_8CF0D98_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B62E4368_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_2D0066D3_Out_0 = float2(_Property_8CF0D98_Out_0, _Property_B62E4368_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B3096413_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_DD0E7210_Out_2;
                Unity_Add_float2(_Vector2_2D0066D3_Out_0, (_Property_B3096413_Out_0.xx), _Add_DD0E7210_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_6BAAF88A_Out_3;
                Unity_Remap_float(_Split_CD01958C_B_3, float2 (0, 1), _Add_DD0E7210_Out_2, _Remap_6BAAF88A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_BFE93ACB_Out_2;
                Unity_Multiply_float(_Multiply_BA3245FD_Out_2, _Remap_6BAAF88A_Out_3, _Multiply_BFE93ACB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D85587E1_Out_2;
                Unity_Multiply_float(_Split_B448FD28_G_2, _Multiply_BFE93ACB_Out_2, _Multiply_D85587E1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_1BD2E7C3_Out_1;
                Unity_Saturate_float(_Multiply_D85587E1_Out_2, _Saturate_1BD2E7C3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_6F17250E_Out_2;
                Unity_Multiply_float(_Clamp_C182A13B_Out_3, _Saturate_1BD2E7C3_Out_1, _Multiply_6F17250E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A3223D36_Out_3;
                Unity_Clamp_float(_Multiply_6F17250E_Out_2, 0, 1, _Clamp_A3223D36_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_33C9D57A_Out_0 = _Clamp_A3223D36_Out_3;
                #else
                float _UseDynamicCoverTStaticMaskF_33C9D57A_Out_0 = _Clamp_C182A13B_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_11D84EE9_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_55BF1AC2_OutVector4_1, (_Multiply_E963B30_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_33C9D57A_Out_0.xxx), _Lerp_11D84EE9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_DCA3E424_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_6067A678_Out_2;
                Unity_Multiply_float((_Property_DCA3E424_Out_0.xyz), _Lerp_11D84EE9_Out_3, _Multiply_6067A678_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_61228C0A_Out_1;
                Unity_OneMinus_float(_Split_B448FD28_R_1, _OneMinus_61228C0A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_F40C1057_Out_3;
                Unity_Lerp_float3(_Lerp_11D84EE9_Out_3, _Multiply_6067A678_Out_2, (_OneMinus_61228C0A_Out_1.xxx), _Lerp_F40C1057_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9CE54B68_R_1 = _PlanarNM_2B81B7D6_XZ_2[0];
                float _Split_9CE54B68_G_2 = _PlanarNM_2B81B7D6_XZ_2[1];
                float _Split_9CE54B68_B_3 = _PlanarNM_2B81B7D6_XZ_2[2];
                float _Split_9CE54B68_A_4 = _PlanarNM_2B81B7D6_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4BAFEB7E_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_F40C1057_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Alpha = _Split_9CE54B68_A_4;
                surface.AlphaClipThreshold = _Property_4BAFEB7E_Out_0;
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
                #if defined(KEYWORD_PERMUTATION_0)
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
                float4 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
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
                output.interp02.xyzw = input.color;
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
                output.color = input.interp02.xyzw;
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
            
            #if defined(KEYWORD_PERMUTATION_0)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
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
            
            
            #if defined(KEYWORD_PERMUTATION_0)
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
        
        #if defined(KEYWORD_PERMUTATION_0)
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
            float _BaseNormalScale;
            float _BaseMetallic;
            float _BaseAORemapMin;
            float _BaseAORemapMax;
            float _BaseSmoothnessRemapMin;
            float _BaseSmoothnessRemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float _CoverUsePlanarUV;
            float4 _CoverTilingOffset;
            float _CoverNormalScale;
            float _CoverNormalBlendHardness;
            float _CoverHardness;
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
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            TEXTURE2D(_DetailMap); SAMPLER(sampler_DetailMap); float4 _DetailMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_8AEB0D9D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D5922584_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
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
            
            void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
            {
                Out = normalize(float3(A.rg + B.rg, A.b * B.b));
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
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E1EA6E56;
                float3 _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E1EA6E56, _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E1EA6E56_ObjectSpacePosition_1;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0)
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
                float4 _Property_D4D1ED47_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_32F61C5C_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2B81B7D6;
                _PlanarNM_2B81B7D6.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2B81B7D6.uv0 = IN.uv0;
                float4 _PlanarNM_2B81B7D6_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNM_2B81B7D6, _PlanarNM_2B81B7D6_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_55050202_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_FAA2BB0D_Out_2;
                Unity_Multiply_float(_PlanarNM_2B81B7D6_XZ_2, _Property_55050202_Out_0, _Multiply_FAA2BB0D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_185DA6A6_Out_0 = _DetailTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_FBE1466A_R_1 = _Property_185DA6A6_Out_0[0];
                float _Split_FBE1466A_G_2 = _Property_185DA6A6_Out_0[1];
                float _Split_FBE1466A_B_3 = _Property_185DA6A6_Out_0[2];
                float _Split_FBE1466A_A_4 = _Property_185DA6A6_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_660A707_Out_0 = float2(_Split_FBE1466A_R_1, _Split_FBE1466A_G_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_2F7FE559_Out_0 = float2(_Split_FBE1466A_B_3, _Split_FBE1466A_A_4);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _TilingAndOffset_DFA3F3E4_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_660A707_Out_0, _Vector2_2F7FE559_Out_0, _TilingAndOffset_DFA3F3E4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_8AEB0D9D_RGBA_0 = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, _TilingAndOffset_DFA3F3E4_Out_3);
                float _SampleTexture2D_8AEB0D9D_R_4 = _SampleTexture2D_8AEB0D9D_RGBA_0.r;
                float _SampleTexture2D_8AEB0D9D_G_5 = _SampleTexture2D_8AEB0D9D_RGBA_0.g;
                float _SampleTexture2D_8AEB0D9D_B_6 = _SampleTexture2D_8AEB0D9D_RGBA_0.b;
                float _SampleTexture2D_8AEB0D9D_A_7 = _SampleTexture2D_8AEB0D9D_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_A64FC943_Out_2;
                Unity_Multiply_float(_SampleTexture2D_8AEB0D9D_R_4, 2, _Multiply_A64FC943_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Add_8D09FB55_Out_2;
                Unity_Add_float(_Multiply_A64FC943_Out_2, -1, _Add_8D09FB55_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6F7C9F70_Out_0 = _DetailAlbedoScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_8DDF8FBF_Out_2;
                Unity_Multiply_float(_Add_8D09FB55_Out_2, _Property_6F7C9F70_Out_0, _Multiply_8DDF8FBF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Saturate_40203200_Out_1;
                Unity_Saturate_float(_Multiply_8DDF8FBF_Out_2, _Saturate_40203200_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Absolute_7B0CA0BA_Out_1;
                Unity_Absolute_float(_Saturate_40203200_Out_1, _Absolute_7B0CA0BA_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2 _BlendOverlayBaseColor_55BF1AC2;
                float3 _BlendOverlayBaseColor_55BF1AC2_OutVector4_1;
                SG_BlendOverlayBaseColor_acdb3dfca72bd6b42bbc35f4613331a2(_Multiply_FAA2BB0D_Out_2, _Add_8D09FB55_Out_2, _Absolute_7B0CA0BA_Out_1, _BlendOverlayBaseColor_55BF1AC2, _BlendOverlayBaseColor_55BF1AC2_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_7DAB730A_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_70C98109_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_555DEA41;
                _PlanarNM_555DEA41.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_555DEA41.uv0 = IN.uv0;
                float4 _PlanarNM_555DEA41_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNM_555DEA41, _PlanarNM_555DEA41_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_746EB831_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_E963B30_Out_2;
                Unity_Multiply_float(_PlanarNM_555DEA41_XZ_2, _Property_746EB831_Out_0, _Multiply_E963B30_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_B578532A_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_D5922584_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_B578532A_Out_0.xy));
                float _SampleTexture2D_D5922584_R_4 = _SampleTexture2D_D5922584_RGBA_0.r;
                float _SampleTexture2D_D5922584_G_5 = _SampleTexture2D_D5922584_RGBA_0.g;
                float _SampleTexture2D_D5922584_B_6 = _SampleTexture2D_D5922584_RGBA_0.b;
                float _SampleTexture2D_D5922584_A_7 = _SampleTexture2D_D5922584_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_B66134FE_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_A77851BF_Out_2;
                Unity_Multiply_float(_SampleTexture2D_D5922584_A_7, _Property_B66134FE_Out_0, _Multiply_A77851BF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_C182A13B_Out_3;
                Unity_Clamp_float(_Multiply_A77851BF_Out_2, 0, 1, _Clamp_C182A13B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_B448FD28_R_1 = IN.VertexColor[0];
                float _Split_B448FD28_G_2 = IN.VertexColor[1];
                float _Split_B448FD28_B_3 = IN.VertexColor[2];
                float _Split_B448FD28_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_49FC42EC_Out_0 = float2(_SampleTexture2D_8AEB0D9D_A_7, _SampleTexture2D_8AEB0D9D_G_5);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_71EE890B_Out_2;
                Unity_Multiply_float(_Vector2_49FC42EC_Out_0, float2(2, 2), _Multiply_71EE890B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_479AB869_Out_2;
                Unity_Add_float2(_Multiply_71EE890B_Out_2, float2(-1, -1), _Add_479AB869_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_CB2C500_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Multiply_C04FAABC_Out_2;
                Unity_Multiply_float(_Add_479AB869_Out_2, (_Property_CB2C500_Out_0.xx), _Multiply_C04FAABC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_BD18AABD_R_1 = _Multiply_C04FAABC_Out_2[0];
                float _Split_BD18AABD_G_2 = _Multiply_C04FAABC_Out_2[1];
                float _Split_BD18AABD_B_3 = 0;
                float _Split_BD18AABD_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _DotProduct_F55479F2_Out_2;
                Unity_DotProduct_float2(_Multiply_C04FAABC_Out_2, _Multiply_C04FAABC_Out_2, _DotProduct_F55479F2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_16F1DB17_Out_1;
                Unity_Saturate_float(_DotProduct_F55479F2_Out_2, _Saturate_16F1DB17_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_2E8C65BE_Out_1;
                Unity_OneMinus_float(_Saturate_16F1DB17_Out_1, _OneMinus_2E8C65BE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _SquareRoot_A1EE594A_Out_1;
                Unity_SquareRoot_float(_OneMinus_2E8C65BE_Out_1, _SquareRoot_A1EE594A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Vector3_64C27CDB_Out_0 = float3(_Split_BD18AABD_R_1, _Split_BD18AABD_G_2, _SquareRoot_A1EE594A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_2E82066A;
                _PlanarNMn_2E82066A.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_2E82066A.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_2E82066A.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_2E82066A.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_2E82066A.uv0 = IN.uv0;
                float4 _PlanarNMn_2E82066A_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_D4D1ED47_Out_0, _Property_32F61C5C_Out_0, _PlanarNMn_2E82066A, _PlanarNMn_2E82066A_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_197D10B2_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_3739AC6A_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_2E82066A_XZ_2.xyz), _Property_197D10B2_Out_0, _NormalStrength_3739AC6A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalBlend_9FB995E_Out_2;
                Unity_NormalBlend_float(_Vector3_64C27CDB_Out_0, _NormalStrength_3739AC6A_Out_2, _NormalBlend_9FB995E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_F09F2626;
                _PlanarNMn_F09F2626.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_F09F2626.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_F09F2626.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_F09F2626.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_F09F2626.uv0 = IN.uv0;
                float4 _PlanarNMn_F09F2626_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNMn_F09F2626, _PlanarNMn_F09F2626_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_8EB6D07F_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_651E468F_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_F09F2626_XZ_2.xyz), _Property_8EB6D07F_Out_0, _NormalStrength_651E468F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_13A85D2C_R_1 = IN.WorldSpaceNormal[0];
                float _Split_13A85D2C_G_2 = IN.WorldSpaceNormal[1];
                float _Split_13A85D2C_B_3 = IN.WorldSpaceNormal[2];
                float _Split_13A85D2C_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7335D6FA_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_ACA0CF6E_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_56C48BF2_Out_2;
                Unity_Subtract_float(4, _Property_ACA0CF6E_Out_0, _Subtract_56C48BF2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_3C1B250C_Out_2;
                Unity_Divide_float(_Property_7335D6FA_Out_0, _Subtract_56C48BF2_Out_2, _Divide_3C1B250C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_418CF584_Out_1;
                Unity_Absolute_float(_Divide_3C1B250C_Out_2, _Absolute_418CF584_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_B95C2CD8_Out_2;
                Unity_Power_float(_Absolute_418CF584_Out_1, _Subtract_56C48BF2_Out_2, _Power_B95C2CD8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_5D011C95_Out_3;
                Unity_Clamp_float(_Power_B95C2CD8_Out_2, 0, 2, _Clamp_5D011C95_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_2639178A_Out_2;
                Unity_Multiply_float(_Split_13A85D2C_G_2, _Clamp_5D011C95_Out_3, _Multiply_2639178A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_71FE7D8D_Out_1;
                Unity_Saturate_float(_Multiply_2639178A_Out_2, _Saturate_71FE7D8D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_DDC6BC83_Out_3;
                Unity_Clamp_float(_Split_13A85D2C_G_2, 0, 0.9999, _Clamp_DDC6BC83_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_1C09E3E3_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_CA17F432_Out_2;
                Unity_Divide_float(_Property_1C09E3E3_Out_0, 45, _Divide_CA17F432_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_9F8CA044_Out_1;
                Unity_OneMinus_float(_Divide_CA17F432_Out_2, _OneMinus_9F8CA044_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_375F1241_Out_2;
                Unity_Subtract_float(_Clamp_DDC6BC83_Out_3, _OneMinus_9F8CA044_Out_1, _Subtract_375F1241_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_B4ABAE50_Out_3;
                Unity_Clamp_float(_Subtract_375F1241_Out_2, 0, 2, _Clamp_B4ABAE50_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_6DAADCFF_Out_2;
                Unity_Divide_float(1, _Divide_CA17F432_Out_2, _Divide_6DAADCFF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5664838C_Out_2;
                Unity_Multiply_float(_Clamp_B4ABAE50_Out_3, _Divide_6DAADCFF_Out_2, _Multiply_5664838C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_BEC83B5_Out_1;
                Unity_Absolute_float(_Multiply_5664838C_Out_2, _Absolute_BEC83B5_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7EA17782_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_5A144FE_Out_2;
                Unity_Power_float(_Absolute_BEC83B5_Out_1, _Property_7EA17782_Out_0, _Power_5A144FE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_488913EE_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_1AF0460E_Out_1;
                Unity_OneMinus_float(_Property_488913EE_Out_0, _OneMinus_1AF0460E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_34217464_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_34217464_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_34217464_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_34217464_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D91B7DB4_Out_2;
                Unity_Add_float(_OneMinus_1AF0460E_Out_1, _Split_34217464_G_2, _Add_D91B7DB4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_D26FB8B9_Out_2;
                Unity_Add_float(_Add_D91B7DB4_Out_2, 1, _Add_D26FB8B9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_576A24A0_Out_3;
                Unity_Clamp_float(_Add_D26FB8B9_Out_2, 0, 1, _Clamp_576A24A0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_7616F871_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DF03E9C4_Out_2;
                Unity_Add_float(_Add_D91B7DB4_Out_2, _Property_7616F871_Out_0, _Add_DF03E9C4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_203EE78E_Out_2;
                Unity_Divide_float(_Add_DF03E9C4_Out_2, _Add_D91B7DB4_Out_2, _Divide_203EE78E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_516ABAA3_Out_1;
                Unity_OneMinus_float(_Divide_203EE78E_Out_2, _OneMinus_516ABAA3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F150E343_Out_2;
                Unity_Add_float(_OneMinus_516ABAA3_Out_1, -0.5, _Add_F150E343_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_70010EDF_Out_3;
                Unity_Clamp_float(_Add_F150E343_Out_2, 0, 1, _Clamp_70010EDF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_F92F5732_Out_2;
                Unity_Add_float(_Clamp_576A24A0_Out_3, _Clamp_70010EDF_Out_3, _Add_F92F5732_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_3DD32DC1_Out_3;
                Unity_Clamp_float(_Add_F92F5732_Out_2, 0, 1, _Clamp_3DD32DC1_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D6F10F20_Out_2;
                Unity_Multiply_float(_Power_5A144FE_Out_2, _Clamp_3DD32DC1_Out_3, _Multiply_D6F10F20_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_E033E66D_Out_2;
                Unity_Multiply_float(_Saturate_71FE7D8D_Out_1, _Multiply_D6F10F20_Out_2, _Multiply_E033E66D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_C13A552C_Out_3;
                Unity_Lerp_float3(_NormalBlend_9FB995E_Out_2, _NormalStrength_651E468F_Out_2, (_Multiply_E033E66D_Out_2.xxx), _Lerp_C13A552C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_E9DA5BB7_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_E9DA5BB7_Out_1 = normalize(mul(Transform_E9DA5BB7_transposeTangent, _Lerp_C13A552C_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_7BBB0748_R_1 = _Transform_E9DA5BB7_Out_1[0];
                float _Split_7BBB0748_G_2 = _Transform_E9DA5BB7_Out_1[1];
                float _Split_7BBB0748_B_3 = _Transform_E9DA5BB7_Out_1[2];
                float _Split_7BBB0748_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_727F09BD_Out_2;
                Unity_Multiply_float(_Split_7BBB0748_G_2, _Clamp_5D011C95_Out_3, _Multiply_727F09BD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_46F6187F_Out_2;
                Unity_Multiply_float(_Clamp_5D011C95_Out_3, _Property_7EA17782_Out_0, _Multiply_46F6187F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_95DA832F_Out_2;
                Unity_Multiply_float(_Multiply_46F6187F_Out_2, _Multiply_D6F10F20_Out_2, _Multiply_95DA832F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_BA3245FD_Out_2;
                Unity_Multiply_float(_Multiply_727F09BD_Out_2, _Multiply_95DA832F_Out_2, _Multiply_BA3245FD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_644BF3FC;
                _PlanarNM_644BF3FC.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_644BF3FC.uv0 = IN.uv0;
                float4 _PlanarNM_644BF3FC_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_7DAB730A_Out_0, _Property_70C98109_Out_0, _PlanarNM_644BF3FC, _PlanarNM_644BF3FC_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_CD01958C_R_1 = _PlanarNM_644BF3FC_XZ_2[0];
                float _Split_CD01958C_G_2 = _PlanarNM_644BF3FC_XZ_2[1];
                float _Split_CD01958C_B_3 = _PlanarNM_644BF3FC_XZ_2[2];
                float _Split_CD01958C_A_4 = _PlanarNM_644BF3FC_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_8CF0D98_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B62E4368_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_2D0066D3_Out_0 = float2(_Property_8CF0D98_Out_0, _Property_B62E4368_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_B3096413_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_DD0E7210_Out_2;
                Unity_Add_float2(_Vector2_2D0066D3_Out_0, (_Property_B3096413_Out_0.xx), _Add_DD0E7210_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_6BAAF88A_Out_3;
                Unity_Remap_float(_Split_CD01958C_B_3, float2 (0, 1), _Add_DD0E7210_Out_2, _Remap_6BAAF88A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_BFE93ACB_Out_2;
                Unity_Multiply_float(_Multiply_BA3245FD_Out_2, _Remap_6BAAF88A_Out_3, _Multiply_BFE93ACB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_D85587E1_Out_2;
                Unity_Multiply_float(_Split_B448FD28_G_2, _Multiply_BFE93ACB_Out_2, _Multiply_D85587E1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_1BD2E7C3_Out_1;
                Unity_Saturate_float(_Multiply_D85587E1_Out_2, _Saturate_1BD2E7C3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_6F17250E_Out_2;
                Unity_Multiply_float(_Clamp_C182A13B_Out_3, _Saturate_1BD2E7C3_Out_1, _Multiply_6F17250E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A3223D36_Out_3;
                Unity_Clamp_float(_Multiply_6F17250E_Out_2, 0, 1, _Clamp_A3223D36_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_33C9D57A_Out_0 = _Clamp_A3223D36_Out_3;
                #else
                float _UseDynamicCoverTStaticMaskF_33C9D57A_Out_0 = _Clamp_C182A13B_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_11D84EE9_Out_3;
                Unity_Lerp_float3(_BlendOverlayBaseColor_55BF1AC2_OutVector4_1, (_Multiply_E963B30_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_33C9D57A_Out_0.xxx), _Lerp_11D84EE9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_DCA3E424_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_6067A678_Out_2;
                Unity_Multiply_float((_Property_DCA3E424_Out_0.xyz), _Lerp_11D84EE9_Out_3, _Multiply_6067A678_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_61228C0A_Out_1;
                Unity_OneMinus_float(_Split_B448FD28_R_1, _OneMinus_61228C0A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_F40C1057_Out_3;
                Unity_Lerp_float3(_Lerp_11D84EE9_Out_3, _Multiply_6067A678_Out_2, (_OneMinus_61228C0A_Out_1.xxx), _Lerp_F40C1057_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_9CE54B68_R_1 = _PlanarNM_2B81B7D6_XZ_2[0];
                float _Split_9CE54B68_G_2 = _PlanarNM_2B81B7D6_XZ_2[1];
                float _Split_9CE54B68_B_3 = _PlanarNM_2B81B7D6_XZ_2[2];
                float _Split_9CE54B68_A_4 = _PlanarNM_2B81B7D6_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4BAFEB7E_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_F40C1057_Out_3;
                surface.Alpha = _Split_9CE54B68_A_4;
                surface.AlphaClipThreshold = _Property_4BAFEB7E_Out_0;
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
                #if defined(KEYWORD_PERMUTATION_0)
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
                float4 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
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
                output.interp02.xyzw = input.color;
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
                output.color = input.interp02.xyzw;
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
            
            #if defined(KEYWORD_PERMUTATION_0)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0)
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
            
            
            #if defined(KEYWORD_PERMUTATION_0)
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
