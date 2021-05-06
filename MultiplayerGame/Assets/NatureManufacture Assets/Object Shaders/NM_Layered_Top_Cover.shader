Shader "NatureManufacture/URP/Layered/Top Cover"
{
    Properties
    {
        _AlphaCutoff("Alpha Cutoff", Range(0, 1)) = 0
        _BaseColor("Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_BaseColorMap("Base Map(RGB) Alpha(A)", 2D) = "white" {}
        [ToggleUI]_BaseUsePlanarUV("Base Use Planar UV", Float) = 0
        _BaseTilingOffset("Base Tiling and Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_BaseNormalMap("Base Normal Map", 2D) = "bump" {}
        _BaseNormalScale("Base Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_BaseMaskMap("Base Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
        _BaseMetallic("Base Metallic", Range(0, 1)) = 1
        _BaseAORemapMin("Base AO Remap Min", Range(0, 1)) = 0
        _BaseAORemapMax("Base AO Remap Max", Range(0, 1)) = 1
        _BaseSmoothnessRemapMin("Base Smoothness Remap Min", Range(0, 1)) = 0
        _BaseSmoothnessRemapMax("Base Smoothness Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_LayerMask("Layer Mask (R)", 2D) = "black" {}
        [ToggleUI]_Invert_Layer_Mask("Invert Layer Mask", Float) = 0
        _Height_Transition("Height Blend Transition", Range(0.001, 1)) = 1
        _HeightMin("Height Min", Float) = 0
        _HeightMax("Height Max", Float) = 1
        _HeightOffset("Height Offset", Float) = 0
        _HeightMin2("Height 2 Min", Float) = 0
        _HeightMax2("Height 2 Max", Float) = 1
        _HeightOffset2("Height 2 Offset", Float) = 0
        _Base2Color("Base 2 Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_Base2ColorMap("Base 2 Map", 2D) = "white" {}
        _Base2TilingOffset("Base 2 Tiling and Offset", Vector) = (1, 1, 0, 0)
        [ToggleUI]_Base2UsePlanarUV("Base 2 Use Planar UV", Float) = 0
        [NoScaleOffset]_Base2NormalMap("Base 2 Normal Map", 2D) = "bump" {}
        _Base2NormalScale("Base 2 Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_Base2MaskMap("Base 2 Mask Map MT(R) AO(G) H(B) SM(A)", 2D) = "white" {}
        _Base2Metallic("Base 2 Metallic", Range(0, 1)) = 1
        _Base2SmoothnessRemapMin("Base 2 Smoothness Remap Min", Range(0, 1)) = 0
        _Base2SmoothnessRemapMax("Base 2 Smoothness Remap Max", Range(0, 1)) = 1
        _Base2AORemapMin("Base 2 AO Remap Min", Range(0, 1)) = 0
        _Base2AORemapMax("Base 2 AO Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_CoverMaskA("Cover Mask (A)", 2D) = "white" {}
        _CoverMaskPower("Cover Mask Power", Range(0, 10)) = 1
        _Cover_Amount("Cover Amount", Range(0, 2)) = 0
        _Cover_Amount_Grow_Speed("Cover Amount Grow Speed", Range(0, 3)) = 3
        _Cover_Max_Angle("Cover Max Angle", Range(0.001, 90)) = 35
        _Cover_Min_Height("Cover Min Height", Float) = -10000
        _Cover_Min_Height_Blending("Cover Min Height Blending", Range(0, 500)) = 1
        _CoverBaseColor("Cover Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_CoverBaseColorMap("Cover Base Map", 2D) = "white" {}
        _CoverTilingOffset("Cover Tiling Offset", Vector) = (1, 1, 0, 0)
        [ToggleUI]_CoverUsePlanarUV("Cover Use Planar UV", Float) = 0
        [NoScaleOffset]_CoverNormalMap("Cover Normal Map", 2D) = "bump" {}
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
            float _Invert_Layer_Mask;
            float _Height_Transition;
            float _HeightMin;
            float _HeightMax;
            float _HeightOffset;
            float _HeightMin2;
            float _HeightMax2;
            float _HeightOffset2;
            float4 _Base2Color;
            float4 _Base2TilingOffset;
            float _Base2UsePlanarUV;
            float _Base2NormalScale;
            float _Base2Metallic;
            float _Base2SmoothnessRemapMin;
            float _Base2SmoothnessRemapMax;
            float _Base2AORemapMin;
            float _Base2AORemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverUsePlanarUV;
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
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_Base2ColorMap); SAMPLER(sampler_Base2ColorMap); float4 _Base2ColorMap_TexelSize;
            TEXTURE2D(_Base2NormalMap); SAMPLER(sampler_Base2NormalMap); float4 _Base2NormalMap_TexelSize;
            TEXTURE2D(_Base2MaskMap); SAMPLER(sampler_Base2MaskMap); float4 _Base2MaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_2B947FAD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_35AD8895_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Maximum_float(float A, float B, out float Out)
            {
                Out = max(A, B);
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A / B;
            }
            
            struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
            {
            };
            
            void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
            {
                float3 _Property_CE7501EE_Out_0 = Vector3_88EEBB5E;
                float _Property_21A77CD2_Out_0 = Vector1_DA0A37FA;
                float _Property_B0F6C734_Out_0 = Vector1_DA0A37FA;
                float _Property_F32C0509_Out_0 = Vector1_F7E83F1E;
                float _Maximum_2C42CE33_Out_2;
                Unity_Maximum_float(_Property_B0F6C734_Out_0, _Property_F32C0509_Out_0, _Maximum_2C42CE33_Out_2);
                float _Property_FBC3A76E_Out_0 = Vector1_1C9222A6;
                float _Subtract_5E32B1F2_Out_2;
                Unity_Subtract_float(_Maximum_2C42CE33_Out_2, _Property_FBC3A76E_Out_0, _Subtract_5E32B1F2_Out_2);
                float _Subtract_AE0D0FB3_Out_2;
                Unity_Subtract_float(_Property_21A77CD2_Out_0, _Subtract_5E32B1F2_Out_2, _Subtract_AE0D0FB3_Out_2);
                float _Maximum_B94A8EBA_Out_2;
                Unity_Maximum_float(_Subtract_AE0D0FB3_Out_2, 0, _Maximum_B94A8EBA_Out_2);
                float3 _Multiply_6D1F195B_Out_2;
                Unity_Multiply_float(_Property_CE7501EE_Out_0, (_Maximum_B94A8EBA_Out_2.xxx), _Multiply_6D1F195B_Out_2);
                float3 _Property_94C053EA_Out_0 = Vector3_79AA92F;
                float _Property_B5C791CC_Out_0 = Vector1_F7E83F1E;
                float _Subtract_5DDA2278_Out_2;
                Unity_Subtract_float(_Property_B5C791CC_Out_0, _Subtract_5E32B1F2_Out_2, _Subtract_5DDA2278_Out_2);
                float _Maximum_3087B5D0_Out_2;
                Unity_Maximum_float(_Subtract_5DDA2278_Out_2, 0, _Maximum_3087B5D0_Out_2);
                float3 _Multiply_61466A85_Out_2;
                Unity_Multiply_float(_Property_94C053EA_Out_0, (_Maximum_3087B5D0_Out_2.xxx), _Multiply_61466A85_Out_2);
                float3 _Add_87880A51_Out_2;
                Unity_Add_float3(_Multiply_6D1F195B_Out_2, _Multiply_61466A85_Out_2, _Add_87880A51_Out_2);
                float _Add_43856DBF_Out_2;
                Unity_Add_float(_Maximum_B94A8EBA_Out_2, _Maximum_3087B5D0_Out_2, _Add_43856DBF_Out_2);
                float _Maximum_47B2BE36_Out_2;
                Unity_Maximum_float(_Add_43856DBF_Out_2, 1E-05, _Maximum_47B2BE36_Out_2);
                float3 _Divide_593AB2EB_Out_2;
                Unity_Divide_float3(_Add_87880A51_Out_2, (_Maximum_47B2BE36_Out_2.xxx), _Divide_593AB2EB_Out_2);
                OutVector4_1 = _Divide_593AB2EB_Out_2;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
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
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Lerp_float(float A, float B, float T, out float Out)
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E5D3779D;
                float3 _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E5D3779D, _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
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
                float4 _Property_A6DEAB8F_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C3635EE5_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_C512A3B9;
                _PlanarNM_C512A3B9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_C512A3B9.uv0 = IN.uv0;
                float4 _PlanarNM_C512A3B9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_C512A3B9, _PlanarNM_C512A3B9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2FD303FC_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_C587B50_Out_2;
                Unity_Multiply_float(_PlanarNM_C512A3B9_XZ_2, _Property_2FD303FC_Out_0, _Multiply_C587B50_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_3D868FEF;
                _PlanarNM_3D868FEF.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_3D868FEF.uv0 = IN.uv0;
                float4 _PlanarNM_3D868FEF_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_3D868FEF, _PlanarNM_3D868FEF_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_1925DEC3_R_1 = _PlanarNM_3D868FEF_XZ_2[0];
                float _Split_1925DEC3_G_2 = _PlanarNM_3D868FEF_XZ_2[1];
                float _Split_1925DEC3_B_3 = _PlanarNM_3D868FEF_XZ_2[2];
                float _Split_1925DEC3_A_4 = _PlanarNM_3D868FEF_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_FC207EAA_Out_0 = _HeightMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EA6A8126_Out_0 = _HeightMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_AE7661E9_Out_0 = float2(_Property_FC207EAA_Out_0, _Property_EA6A8126_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_84099320_Out_0 = _HeightOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_DC3BF6BC_Out_2;
                Unity_Add_float2(_Vector2_AE7661E9_Out_0, (_Property_84099320_Out_0.xx), _Add_DC3BF6BC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_EEF11503_Out_3;
                Unity_Remap_float(_Split_1925DEC3_B_3, float2 (0, 1), _Add_DC3BF6BC_Out_2, _Remap_EEF11503_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2D1893AC_Out_0 = _Base2TilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_225AB14B_Out_0 = _Base2UsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2D1D7349;
                _PlanarNM_2D1D7349.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2D1D7349.uv0 = IN.uv0;
                float4 _PlanarNM_2D1D7349_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNM_2D1D7349, _PlanarNM_2D1D7349_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_C338F812_Out_0 = _Base2Color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_55DF5EEA_Out_2;
                Unity_Multiply_float(_PlanarNM_2D1D7349_XZ_2, _Property_C338F812_Out_0, _Multiply_55DF5EEA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_1F16AC11_R_1 = IN.VertexColor[0];
                float _Split_1F16AC11_G_2 = IN.VertexColor[1];
                float _Split_1F16AC11_B_3 = IN.VertexColor[2];
                float _Split_1F16AC11_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_45C5314D_Out_0 = _Invert_Layer_Mask;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_2B947FAD_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                float _SampleTexture2D_2B947FAD_R_4 = _SampleTexture2D_2B947FAD_RGBA_0.r;
                float _SampleTexture2D_2B947FAD_G_5 = _SampleTexture2D_2B947FAD_RGBA_0.g;
                float _SampleTexture2D_2B947FAD_B_6 = _SampleTexture2D_2B947FAD_RGBA_0.b;
                float _SampleTexture2D_2B947FAD_A_7 = _SampleTexture2D_2B947FAD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_6D8E0CA7_Out_1;
                Unity_OneMinus_float(_SampleTexture2D_2B947FAD_R_4, _OneMinus_6D8E0CA7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Branch_7B7E6F83_Out_3;
                Unity_Branch_float(_Property_45C5314D_Out_0, _OneMinus_6D8E0CA7_Out_1, _SampleTexture2D_2B947FAD_R_4, _Branch_7B7E6F83_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_EFAFFD27;
                _PlanarNM_EFAFFD27.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_EFAFFD27.uv0 = IN.uv0;
                float4 _PlanarNM_EFAFFD27_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNM_EFAFFD27, _PlanarNM_EFAFFD27_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_EA4A8B31_R_1 = _PlanarNM_EFAFFD27_XZ_2[0];
                float _Split_EA4A8B31_G_2 = _PlanarNM_EFAFFD27_XZ_2[1];
                float _Split_EA4A8B31_B_3 = _PlanarNM_EFAFFD27_XZ_2[2];
                float _Split_EA4A8B31_A_4 = _PlanarNM_EFAFFD27_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_99B8719D_Out_0 = _HeightMin2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4E5D833F_Out_0 = _HeightMax2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_3AF95429_Out_0 = float2(_Property_99B8719D_Out_0, _Property_4E5D833F_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_205C1A31_Out_0 = _HeightOffset2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_9F9AAF1B_Out_2;
                Unity_Add_float2(_Vector2_3AF95429_Out_0, (_Property_205C1A31_Out_0.xx), _Add_9F9AAF1B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_D6919CF_Out_3;
                Unity_Remap_float(_Split_EA4A8B31_B_3, float2 (0, 1), _Add_9F9AAF1B_Out_2, _Remap_D6919CF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_FF4F47A5_Out_2;
                Unity_Multiply_float(_Branch_7B7E6F83_Out_3, _Remap_D6919CF_Out_3, _Multiply_FF4F47A5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_930C89A1_Out_2;
                Unity_Multiply_float(_Split_1F16AC11_B_3, _Multiply_FF4F47A5_Out_2, _Multiply_930C89A1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_736BD634_Out_0 = _Height_Transition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_2075C0A0;
                float3 _HeightBlend_2075C0A0_OutVector4_1;
                SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_C587B50_Out_2.xyz), _Remap_EEF11503_Out_3, (_Multiply_55DF5EEA_Out_2.xyz), _Multiply_930C89A1_Out_2, _Property_736BD634_Out_0, _HeightBlend_2075C0A0, _HeightBlend_2075C0A0_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_947561E_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_72A8F044_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_7373B1C3;
                _PlanarNM_7373B1C3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_7373B1C3.uv0 = IN.uv0;
                float4 _PlanarNM_7373B1C3_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNM_7373B1C3, _PlanarNM_7373B1C3_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2F49B797_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_A3A6847B_Out_2;
                Unity_Multiply_float(_PlanarNM_7373B1C3_XZ_2, _Property_2F49B797_Out_0, _Multiply_A3A6847B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_1E4A4B5D_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_35AD8895_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_1E4A4B5D_Out_0.xy));
                float _SampleTexture2D_35AD8895_R_4 = _SampleTexture2D_35AD8895_RGBA_0.r;
                float _SampleTexture2D_35AD8895_G_5 = _SampleTexture2D_35AD8895_RGBA_0.g;
                float _SampleTexture2D_35AD8895_B_6 = _SampleTexture2D_35AD8895_RGBA_0.b;
                float _SampleTexture2D_35AD8895_A_7 = _SampleTexture2D_35AD8895_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_9504AB9D_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_7828E40F_Out_2;
                Unity_Multiply_float(_SampleTexture2D_35AD8895_A_7, _Property_9504AB9D_Out_0, _Multiply_7828E40F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_9A47E479_Out_3;
                Unity_Clamp_float(_Multiply_7828E40F_Out_2, 0, 1, _Clamp_9A47E479_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_C90B6C74;
                _PlanarNMn_C90B6C74.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_C90B6C74.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_C90B6C74.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_C90B6C74.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_C90B6C74.uv0 = IN.uv0;
                float4 _PlanarNMn_C90B6C74_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNMn_C90B6C74, _PlanarNMn_C90B6C74_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_3EFAC11B_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_46C809A8_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_C90B6C74_XZ_2.xyz), _Property_3EFAC11B_Out_0, _NormalStrength_46C809A8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_75A7E6E1;
                _PlanarNMn_75A7E6E1.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_75A7E6E1.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_75A7E6E1.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_75A7E6E1.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_75A7E6E1.uv0 = IN.uv0;
                float4 _PlanarNMn_75A7E6E1_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNMn_75A7E6E1, _PlanarNMn_75A7E6E1_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_18C7EECE_Out_0 = _Base2NormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_831CDFAC_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_75A7E6E1_XZ_2.xyz), _Property_18C7EECE_Out_0, _NormalStrength_831CDFAC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_EC733D35;
                float3 _HeightBlend_EC733D35_OutVector4_1;
                SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_46C809A8_Out_2, _Remap_EEF11503_Out_3, _NormalStrength_831CDFAC_Out_2, _Multiply_930C89A1_Out_2, _Property_736BD634_Out_0, _HeightBlend_EC733D35, _HeightBlend_EC733D35_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_41586C06;
                _PlanarNMn_41586C06.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_41586C06.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_41586C06.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_41586C06.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_41586C06.uv0 = IN.uv0;
                float4 _PlanarNMn_41586C06_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNMn_41586C06, _PlanarNMn_41586C06_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_497CF3E4_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_98B0A6A_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_41586C06_XZ_2.xyz), _Property_497CF3E4_Out_0, _NormalStrength_98B0A6A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_E816F564_R_1 = IN.WorldSpaceNormal[0];
                float _Split_E816F564_G_2 = IN.WorldSpaceNormal[1];
                float _Split_E816F564_B_3 = IN.WorldSpaceNormal[2];
                float _Split_E816F564_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_EBB9C74F_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_14B49BDA_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_99901F27_Out_2;
                Unity_Subtract_float(4, _Property_14B49BDA_Out_0, _Subtract_99901F27_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_6ECD57E8_Out_2;
                Unity_Divide_float(_Property_EBB9C74F_Out_0, _Subtract_99901F27_Out_2, _Divide_6ECD57E8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_ACF5CF89_Out_1;
                Unity_Absolute_float(_Divide_6ECD57E8_Out_2, _Absolute_ACF5CF89_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_195A75DF_Out_2;
                Unity_Power_float(_Absolute_ACF5CF89_Out_1, _Subtract_99901F27_Out_2, _Power_195A75DF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_31F7C969_Out_3;
                Unity_Clamp_float(_Power_195A75DF_Out_2, 0, 2, _Clamp_31F7C969_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5D2D037B_Out_2;
                Unity_Multiply_float(_Split_E816F564_G_2, _Clamp_31F7C969_Out_3, _Multiply_5D2D037B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_832431F7_Out_1;
                Unity_Saturate_float(_Multiply_5D2D037B_Out_2, _Saturate_832431F7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A5B13DB9_Out_3;
                Unity_Clamp_float(_Split_E816F564_G_2, 0, 0.9999, _Clamp_A5B13DB9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_4EC81755_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_9B40B768_Out_2;
                Unity_Divide_float(_Property_4EC81755_Out_0, 45, _Divide_9B40B768_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_A006C378_Out_1;
                Unity_OneMinus_float(_Divide_9B40B768_Out_2, _OneMinus_A006C378_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_B0272169_Out_2;
                Unity_Subtract_float(_Clamp_A5B13DB9_Out_3, _OneMinus_A006C378_Out_1, _Subtract_B0272169_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_1F415243_Out_3;
                Unity_Clamp_float(_Subtract_B0272169_Out_2, 0, 2, _Clamp_1F415243_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_DACFD30D_Out_2;
                Unity_Divide_float(1, _Divide_9B40B768_Out_2, _Divide_DACFD30D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F9549BCF_Out_2;
                Unity_Multiply_float(_Clamp_1F415243_Out_3, _Divide_DACFD30D_Out_2, _Multiply_F9549BCF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_791D03B7_Out_1;
                Unity_Absolute_float(_Multiply_F9549BCF_Out_2, _Absolute_791D03B7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_944A07C2_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_C2E0783A_Out_2;
                Unity_Power_float(_Absolute_791D03B7_Out_1, _Property_944A07C2_Out_0, _Power_C2E0783A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_69BC1F6D_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_4AF4FC6A_Out_1;
                Unity_OneMinus_float(_Property_69BC1F6D_Out_0, _OneMinus_4AF4FC6A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_7F8FD5EA_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_7F8FD5EA_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_7F8FD5EA_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_7F8FD5EA_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_B7F4D583_Out_2;
                Unity_Add_float(_OneMinus_4AF4FC6A_Out_1, _Split_7F8FD5EA_G_2, _Add_B7F4D583_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DF456C8_Out_2;
                Unity_Add_float(_Add_B7F4D583_Out_2, 1, _Add_DF456C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_DB90E782_Out_3;
                Unity_Clamp_float(_Add_DF456C8_Out_2, 0, 1, _Clamp_DB90E782_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_E7A2779D_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_8921CA8E_Out_2;
                Unity_Add_float(_Add_B7F4D583_Out_2, _Property_E7A2779D_Out_0, _Add_8921CA8E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_EC974C57_Out_2;
                Unity_Divide_float(_Add_8921CA8E_Out_2, _Add_B7F4D583_Out_2, _Divide_EC974C57_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_FA84DDCF_Out_1;
                Unity_OneMinus_float(_Divide_EC974C57_Out_2, _OneMinus_FA84DDCF_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_79EF52AF_Out_2;
                Unity_Add_float(_OneMinus_FA84DDCF_Out_1, -0.5, _Add_79EF52AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A6F2CA6C_Out_3;
                Unity_Clamp_float(_Add_79EF52AF_Out_2, 0, 1, _Clamp_A6F2CA6C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_C11529C0_Out_2;
                Unity_Add_float(_Clamp_DB90E782_Out_3, _Clamp_A6F2CA6C_Out_3, _Add_C11529C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_825E0B27_Out_3;
                Unity_Clamp_float(_Add_C11529C0_Out_2, 0, 1, _Clamp_825E0B27_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F8CC5F92_Out_2;
                Unity_Multiply_float(_Power_C2E0783A_Out_2, _Clamp_825E0B27_Out_3, _Multiply_F8CC5F92_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_9A6D78C0_Out_2;
                Unity_Multiply_float(_Saturate_832431F7_Out_1, _Multiply_F8CC5F92_Out_2, _Multiply_9A6D78C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_422E501D_Out_3;
                Unity_Lerp_float3(_HeightBlend_EC733D35_OutVector4_1, _NormalStrength_98B0A6A_Out_2, (_Multiply_9A6D78C0_Out_2.xxx), _Lerp_422E501D_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_49441AF_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_49441AF_Out_1 = normalize(mul(Transform_49441AF_transposeTangent, _Lerp_422E501D_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_6BFE2A44_R_1 = _Transform_49441AF_Out_1[0];
                float _Split_6BFE2A44_G_2 = _Transform_49441AF_Out_1[1];
                float _Split_6BFE2A44_B_3 = _Transform_49441AF_Out_1[2];
                float _Split_6BFE2A44_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_DCD9BE60_Out_2;
                Unity_Multiply_float(_Split_6BFE2A44_G_2, _Clamp_31F7C969_Out_3, _Multiply_DCD9BE60_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_59524B8D_Out_2;
                Unity_Multiply_float(_Clamp_31F7C969_Out_3, _Property_944A07C2_Out_0, _Multiply_59524B8D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_CF73EDD_Out_2;
                Unity_Multiply_float(_Multiply_59524B8D_Out_2, _Multiply_F8CC5F92_Out_2, _Multiply_CF73EDD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_6091EB57_Out_2;
                Unity_Multiply_float(_Multiply_DCD9BE60_Out_2, _Multiply_CF73EDD_Out_2, _Multiply_6091EB57_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_F10237A8;
                _PlanarNM_F10237A8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_F10237A8.uv0 = IN.uv0;
                float4 _PlanarNM_F10237A8_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNM_F10237A8, _PlanarNM_F10237A8_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_982C095D_R_1 = _PlanarNM_F10237A8_XZ_2[0];
                float _Split_982C095D_G_2 = _PlanarNM_F10237A8_XZ_2[1];
                float _Split_982C095D_B_3 = _PlanarNM_F10237A8_XZ_2[2];
                float _Split_982C095D_A_4 = _PlanarNM_F10237A8_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_C3EF9D20_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_E3A09D98_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_C90CCB0_Out_0 = float2(_Property_C3EF9D20_Out_0, _Property_E3A09D98_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_69DDD5BF_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_6794A75_Out_2;
                Unity_Add_float2(_Vector2_C90CCB0_Out_0, (_Property_69DDD5BF_Out_0.xx), _Add_6794A75_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_42D24C67_Out_3;
                Unity_Remap_float(_Split_982C095D_B_3, float2 (0, 1), _Add_6794A75_Out_2, _Remap_42D24C67_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_3EDCB3E3_Out_2;
                Unity_Multiply_float(_Multiply_6091EB57_Out_2, _Remap_42D24C67_Out_3, _Multiply_3EDCB3E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_7FB2649_Out_2;
                Unity_Multiply_float(_Split_1F16AC11_G_2, _Multiply_3EDCB3E3_Out_2, _Multiply_7FB2649_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_B924FC4D_Out_1;
                Unity_Saturate_float(_Multiply_7FB2649_Out_2, _Saturate_B924FC4D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_EE37C6A7_Out_2;
                Unity_Multiply_float(_Clamp_9A47E479_Out_3, _Saturate_B924FC4D_Out_1, _Multiply_EE37C6A7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_7E3320FD_Out_0 = _Multiply_EE37C6A7_Out_2;
                #else
                float _UseDynamicCoverTStaticMaskF_7E3320FD_Out_0 = _Clamp_9A47E479_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_493CF2FB_Out_3;
                Unity_Lerp_float3(_HeightBlend_2075C0A0_OutVector4_1, (_Multiply_A3A6847B_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_7E3320FD_Out_0.xxx), _Lerp_493CF2FB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_6E1772E4_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_FFF6BF72_Out_2;
                Unity_Multiply_float((_Property_6E1772E4_Out_0.xyz), _Lerp_493CF2FB_Out_3, _Multiply_FFF6BF72_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_E96D8F6B_Out_1;
                Unity_OneMinus_float(_Split_1F16AC11_R_1, _OneMinus_E96D8F6B_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_DA672D44_Out_3;
                Unity_Lerp_float3(_Lerp_493CF2FB_Out_3, _Multiply_FFF6BF72_Out_2, (_OneMinus_E96D8F6B_Out_1.xxx), _Lerp_DA672D44_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_DCD8BC92_Out_0 = _CoverNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _NormalStrength_5E3BBC53_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_41586C06_XZ_2.xyz), _Property_DCD8BC92_Out_0, _NormalStrength_5E3BBC53_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_E5468113_Out_3;
                Unity_Lerp_float3(_HeightBlend_EC733D35_OutVector4_1, _NormalStrength_5E3BBC53_Out_2, (_UseDynamicCoverTStaticMaskF_7E3320FD_Out_0.xxx), _Lerp_E5468113_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_2B3204CD_Out_0 = _BaseMetallic;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_104BCF7A_Out_2;
                Unity_Multiply_float(_Split_1925DEC3_R_1, _Property_2B3204CD_Out_0, _Multiply_104BCF7A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_AD9FD7B8_Out_0 = _BaseAORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_AF8C9403_Out_0 = _BaseAORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_2097E647_Out_0 = float2(_Property_AD9FD7B8_Out_0, _Property_AF8C9403_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_B02C812E_Out_3;
                Unity_Remap_float(_Split_1925DEC3_G_2, float2 (0, 1), _Vector2_2097E647_Out_0, _Remap_B02C812E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_AE178C2F_Out_0 = _BaseSmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_37B5FDB5_Out_0 = _BaseSmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_92F48D0C_Out_0 = float2(_Property_AE178C2F_Out_0, _Property_37B5FDB5_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_9E330CDE_Out_3;
                Unity_Remap_float(_Split_1925DEC3_A_4, float2 (0, 1), _Vector2_92F48D0C_Out_0, _Remap_9E330CDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_CEB18FE4_Out_0 = float3(_Multiply_104BCF7A_Out_2, _Remap_B02C812E_Out_3, _Remap_9E330CDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_54CC173E_Out_0 = _Base2Metallic;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_A06264C9_Out_2;
                Unity_Multiply_float(_Split_EA4A8B31_R_1, _Property_54CC173E_Out_0, _Multiply_A06264C9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_28B36F7_Out_0 = _Base2AORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_A84004E0_Out_0 = _Base2AORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_AC411422_Out_0 = float2(_Property_28B36F7_Out_0, _Property_A84004E0_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_2969C357_Out_3;
                Unity_Remap_float(_Split_EA4A8B31_G_2, float2 (0, 1), _Vector2_AC411422_Out_0, _Remap_2969C357_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4AD4476F_Out_0 = _Base2SmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_D56952B2_Out_0 = _Base2SmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_F4C92992_Out_0 = float2(_Property_4AD4476F_Out_0, _Property_D56952B2_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_9658972E_Out_3;
                Unity_Remap_float(_Split_EA4A8B31_A_4, float2 (0, 1), _Vector2_F4C92992_Out_0, _Remap_9658972E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_8BA1CB91_Out_0 = float3(_Multiply_A06264C9_Out_2, _Remap_2969C357_Out_3, _Remap_9658972E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_32121F96;
                float3 _HeightBlend_32121F96_OutVector4_1;
                SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_Vector3_CEB18FE4_Out_0, _Remap_EEF11503_Out_3, _Vector3_8BA1CB91_Out_0, _Multiply_930C89A1_Out_2, _Property_736BD634_Out_0, _HeightBlend_32121F96, _HeightBlend_32121F96_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_6B1228F5_Out_0 = _CoverMetallic;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_FE1CC024_Out_2;
                Unity_Multiply_float(_Split_982C095D_R_1, _Property_6B1228F5_Out_0, _Multiply_FE1CC024_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4BCF4DA1_Out_0 = _CoverAORemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_53C89720_Out_0 = _CoverAORemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_4A63F1A4_Out_0 = float2(_Property_4BCF4DA1_Out_0, _Property_53C89720_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_D108A9D9_Out_3;
                Unity_Remap_float(_Split_982C095D_G_2, float2 (0, 1), _Vector2_4A63F1A4_Out_0, _Remap_D108A9D9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_264C2307_Out_0 = _CoverSmoothnessRemapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_E4AF2BFC_Out_0 = _CoverSmoothnessRemapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_29815476_Out_0 = float2(_Property_264C2307_Out_0, _Property_E4AF2BFC_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_4D892F5E_Out_3;
                Unity_Remap_float(_Split_982C095D_A_4, float2 (0, 1), _Vector2_29815476_Out_0, _Remap_4D892F5E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Vector3_344E52F4_Out_0 = float3(_Multiply_FE1CC024_Out_2, _Remap_D108A9D9_Out_3, _Remap_4D892F5E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_597693A2_Out_3;
                Unity_Lerp_float3(_HeightBlend_32121F96_OutVector4_1, _Vector3_344E52F4_Out_0, (_UseDynamicCoverTStaticMaskF_7E3320FD_Out_0.xxx), _Lerp_597693A2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_B9152234_R_1 = _Lerp_597693A2_Out_3[0];
                float _Split_B9152234_G_2 = _Lerp_597693A2_Out_3[1];
                float _Split_B9152234_B_3 = _Lerp_597693A2_Out_3[2];
                float _Split_B9152234_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_B242DEA9_Out_0 = _WetSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Lerp_9E8E4302_Out_3;
                Unity_Lerp_float(_Split_B9152234_B_3, _Property_B242DEA9_Out_0, _OneMinus_E96D8F6B_Out_1, _Lerp_9E8E4302_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_6530ACB3_R_1 = _PlanarNM_C512A3B9_XZ_2[0];
                float _Split_6530ACB3_G_2 = _PlanarNM_C512A3B9_XZ_2[1];
                float _Split_6530ACB3_B_3 = _PlanarNM_C512A3B9_XZ_2[2];
                float _Split_6530ACB3_A_4 = _PlanarNM_C512A3B9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_91A5D9D0_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_DA672D44_Out_3;
                surface.Normal = _Lerp_E5468113_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Metallic = _Split_B9152234_R_1;
                surface.Smoothness = _Lerp_9E8E4302_Out_3;
                surface.Occlusion = _Split_B9152234_G_2;
                surface.Alpha = _Split_6530ACB3_A_4;
                surface.AlphaClipThreshold = _Property_91A5D9D0_Out_0;
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
            float _Invert_Layer_Mask;
            float _Height_Transition;
            float _HeightMin;
            float _HeightMax;
            float _HeightOffset;
            float _HeightMin2;
            float _HeightMax2;
            float _HeightOffset2;
            float4 _Base2Color;
            float4 _Base2TilingOffset;
            float _Base2UsePlanarUV;
            float _Base2NormalScale;
            float _Base2Metallic;
            float _Base2SmoothnessRemapMin;
            float _Base2SmoothnessRemapMax;
            float _Base2AORemapMin;
            float _Base2AORemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverUsePlanarUV;
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
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_Base2ColorMap); SAMPLER(sampler_Base2ColorMap); float4 _Base2ColorMap_TexelSize;
            TEXTURE2D(_Base2NormalMap); SAMPLER(sampler_Base2NormalMap); float4 _Base2NormalMap_TexelSize;
            TEXTURE2D(_Base2MaskMap); SAMPLER(sampler_Base2MaskMap); float4 _Base2MaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E5D3779D;
                float3 _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E5D3779D, _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
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
                float4 _Property_A6DEAB8F_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C3635EE5_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_C512A3B9;
                _PlanarNM_C512A3B9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_C512A3B9.uv0 = IN.uv0;
                float4 _PlanarNM_C512A3B9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_C512A3B9, _PlanarNM_C512A3B9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_6530ACB3_R_1 = _PlanarNM_C512A3B9_XZ_2[0];
                float _Split_6530ACB3_G_2 = _PlanarNM_C512A3B9_XZ_2[1];
                float _Split_6530ACB3_B_3 = _PlanarNM_C512A3B9_XZ_2[2];
                float _Split_6530ACB3_A_4 = _PlanarNM_C512A3B9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_91A5D9D0_Out_0 = _AlphaCutoff;
                #endif
                surface.Alpha = _Split_6530ACB3_A_4;
                surface.AlphaClipThreshold = _Property_91A5D9D0_Out_0;
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
            float _Invert_Layer_Mask;
            float _Height_Transition;
            float _HeightMin;
            float _HeightMax;
            float _HeightOffset;
            float _HeightMin2;
            float _HeightMax2;
            float _HeightOffset2;
            float4 _Base2Color;
            float4 _Base2TilingOffset;
            float _Base2UsePlanarUV;
            float _Base2NormalScale;
            float _Base2Metallic;
            float _Base2SmoothnessRemapMin;
            float _Base2SmoothnessRemapMax;
            float _Base2AORemapMin;
            float _Base2AORemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverUsePlanarUV;
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
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_Base2ColorMap); SAMPLER(sampler_Base2ColorMap); float4 _Base2ColorMap_TexelSize;
            TEXTURE2D(_Base2NormalMap); SAMPLER(sampler_Base2NormalMap); float4 _Base2NormalMap_TexelSize;
            TEXTURE2D(_Base2MaskMap); SAMPLER(sampler_Base2MaskMap); float4 _Base2MaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E5D3779D;
                float3 _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E5D3779D, _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
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
                float4 _Property_A6DEAB8F_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C3635EE5_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_C512A3B9;
                _PlanarNM_C512A3B9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_C512A3B9.uv0 = IN.uv0;
                float4 _PlanarNM_C512A3B9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_C512A3B9, _PlanarNM_C512A3B9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_6530ACB3_R_1 = _PlanarNM_C512A3B9_XZ_2[0];
                float _Split_6530ACB3_G_2 = _PlanarNM_C512A3B9_XZ_2[1];
                float _Split_6530ACB3_B_3 = _PlanarNM_C512A3B9_XZ_2[2];
                float _Split_6530ACB3_A_4 = _PlanarNM_C512A3B9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_91A5D9D0_Out_0 = _AlphaCutoff;
                #endif
                surface.Alpha = _Split_6530ACB3_A_4;
                surface.AlphaClipThreshold = _Property_91A5D9D0_Out_0;
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
            float _Invert_Layer_Mask;
            float _Height_Transition;
            float _HeightMin;
            float _HeightMax;
            float _HeightOffset;
            float _HeightMin2;
            float _HeightMax2;
            float _HeightOffset2;
            float4 _Base2Color;
            float4 _Base2TilingOffset;
            float _Base2UsePlanarUV;
            float _Base2NormalScale;
            float _Base2Metallic;
            float _Base2SmoothnessRemapMin;
            float _Base2SmoothnessRemapMax;
            float _Base2AORemapMin;
            float _Base2AORemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverUsePlanarUV;
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
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_Base2ColorMap); SAMPLER(sampler_Base2ColorMap); float4 _Base2ColorMap_TexelSize;
            TEXTURE2D(_Base2NormalMap); SAMPLER(sampler_Base2NormalMap); float4 _Base2NormalMap_TexelSize;
            TEXTURE2D(_Base2MaskMap); SAMPLER(sampler_Base2MaskMap); float4 _Base2MaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_2B947FAD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_35AD8895_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Maximum_float(float A, float B, out float Out)
            {
                Out = max(A, B);
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A / B;
            }
            
            struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
            {
            };
            
            void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
            {
                float3 _Property_CE7501EE_Out_0 = Vector3_88EEBB5E;
                float _Property_21A77CD2_Out_0 = Vector1_DA0A37FA;
                float _Property_B0F6C734_Out_0 = Vector1_DA0A37FA;
                float _Property_F32C0509_Out_0 = Vector1_F7E83F1E;
                float _Maximum_2C42CE33_Out_2;
                Unity_Maximum_float(_Property_B0F6C734_Out_0, _Property_F32C0509_Out_0, _Maximum_2C42CE33_Out_2);
                float _Property_FBC3A76E_Out_0 = Vector1_1C9222A6;
                float _Subtract_5E32B1F2_Out_2;
                Unity_Subtract_float(_Maximum_2C42CE33_Out_2, _Property_FBC3A76E_Out_0, _Subtract_5E32B1F2_Out_2);
                float _Subtract_AE0D0FB3_Out_2;
                Unity_Subtract_float(_Property_21A77CD2_Out_0, _Subtract_5E32B1F2_Out_2, _Subtract_AE0D0FB3_Out_2);
                float _Maximum_B94A8EBA_Out_2;
                Unity_Maximum_float(_Subtract_AE0D0FB3_Out_2, 0, _Maximum_B94A8EBA_Out_2);
                float3 _Multiply_6D1F195B_Out_2;
                Unity_Multiply_float(_Property_CE7501EE_Out_0, (_Maximum_B94A8EBA_Out_2.xxx), _Multiply_6D1F195B_Out_2);
                float3 _Property_94C053EA_Out_0 = Vector3_79AA92F;
                float _Property_B5C791CC_Out_0 = Vector1_F7E83F1E;
                float _Subtract_5DDA2278_Out_2;
                Unity_Subtract_float(_Property_B5C791CC_Out_0, _Subtract_5E32B1F2_Out_2, _Subtract_5DDA2278_Out_2);
                float _Maximum_3087B5D0_Out_2;
                Unity_Maximum_float(_Subtract_5DDA2278_Out_2, 0, _Maximum_3087B5D0_Out_2);
                float3 _Multiply_61466A85_Out_2;
                Unity_Multiply_float(_Property_94C053EA_Out_0, (_Maximum_3087B5D0_Out_2.xxx), _Multiply_61466A85_Out_2);
                float3 _Add_87880A51_Out_2;
                Unity_Add_float3(_Multiply_6D1F195B_Out_2, _Multiply_61466A85_Out_2, _Add_87880A51_Out_2);
                float _Add_43856DBF_Out_2;
                Unity_Add_float(_Maximum_B94A8EBA_Out_2, _Maximum_3087B5D0_Out_2, _Add_43856DBF_Out_2);
                float _Maximum_47B2BE36_Out_2;
                Unity_Maximum_float(_Add_43856DBF_Out_2, 1E-05, _Maximum_47B2BE36_Out_2);
                float3 _Divide_593AB2EB_Out_2;
                Unity_Divide_float3(_Add_87880A51_Out_2, (_Maximum_47B2BE36_Out_2.xxx), _Divide_593AB2EB_Out_2);
                OutVector4_1 = _Divide_593AB2EB_Out_2;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
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
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E5D3779D;
                float3 _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E5D3779D, _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
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
                float4 _Property_A6DEAB8F_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C3635EE5_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_C512A3B9;
                _PlanarNM_C512A3B9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_C512A3B9.uv0 = IN.uv0;
                float4 _PlanarNM_C512A3B9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_C512A3B9, _PlanarNM_C512A3B9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2FD303FC_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_C587B50_Out_2;
                Unity_Multiply_float(_PlanarNM_C512A3B9_XZ_2, _Property_2FD303FC_Out_0, _Multiply_C587B50_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_3D868FEF;
                _PlanarNM_3D868FEF.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_3D868FEF.uv0 = IN.uv0;
                float4 _PlanarNM_3D868FEF_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_3D868FEF, _PlanarNM_3D868FEF_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_1925DEC3_R_1 = _PlanarNM_3D868FEF_XZ_2[0];
                float _Split_1925DEC3_G_2 = _PlanarNM_3D868FEF_XZ_2[1];
                float _Split_1925DEC3_B_3 = _PlanarNM_3D868FEF_XZ_2[2];
                float _Split_1925DEC3_A_4 = _PlanarNM_3D868FEF_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_FC207EAA_Out_0 = _HeightMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EA6A8126_Out_0 = _HeightMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_AE7661E9_Out_0 = float2(_Property_FC207EAA_Out_0, _Property_EA6A8126_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_84099320_Out_0 = _HeightOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_DC3BF6BC_Out_2;
                Unity_Add_float2(_Vector2_AE7661E9_Out_0, (_Property_84099320_Out_0.xx), _Add_DC3BF6BC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_EEF11503_Out_3;
                Unity_Remap_float(_Split_1925DEC3_B_3, float2 (0, 1), _Add_DC3BF6BC_Out_2, _Remap_EEF11503_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2D1893AC_Out_0 = _Base2TilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_225AB14B_Out_0 = _Base2UsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2D1D7349;
                _PlanarNM_2D1D7349.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2D1D7349.uv0 = IN.uv0;
                float4 _PlanarNM_2D1D7349_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNM_2D1D7349, _PlanarNM_2D1D7349_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_C338F812_Out_0 = _Base2Color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_55DF5EEA_Out_2;
                Unity_Multiply_float(_PlanarNM_2D1D7349_XZ_2, _Property_C338F812_Out_0, _Multiply_55DF5EEA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_1F16AC11_R_1 = IN.VertexColor[0];
                float _Split_1F16AC11_G_2 = IN.VertexColor[1];
                float _Split_1F16AC11_B_3 = IN.VertexColor[2];
                float _Split_1F16AC11_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_45C5314D_Out_0 = _Invert_Layer_Mask;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_2B947FAD_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                float _SampleTexture2D_2B947FAD_R_4 = _SampleTexture2D_2B947FAD_RGBA_0.r;
                float _SampleTexture2D_2B947FAD_G_5 = _SampleTexture2D_2B947FAD_RGBA_0.g;
                float _SampleTexture2D_2B947FAD_B_6 = _SampleTexture2D_2B947FAD_RGBA_0.b;
                float _SampleTexture2D_2B947FAD_A_7 = _SampleTexture2D_2B947FAD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_6D8E0CA7_Out_1;
                Unity_OneMinus_float(_SampleTexture2D_2B947FAD_R_4, _OneMinus_6D8E0CA7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Branch_7B7E6F83_Out_3;
                Unity_Branch_float(_Property_45C5314D_Out_0, _OneMinus_6D8E0CA7_Out_1, _SampleTexture2D_2B947FAD_R_4, _Branch_7B7E6F83_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_EFAFFD27;
                _PlanarNM_EFAFFD27.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_EFAFFD27.uv0 = IN.uv0;
                float4 _PlanarNM_EFAFFD27_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNM_EFAFFD27, _PlanarNM_EFAFFD27_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_EA4A8B31_R_1 = _PlanarNM_EFAFFD27_XZ_2[0];
                float _Split_EA4A8B31_G_2 = _PlanarNM_EFAFFD27_XZ_2[1];
                float _Split_EA4A8B31_B_3 = _PlanarNM_EFAFFD27_XZ_2[2];
                float _Split_EA4A8B31_A_4 = _PlanarNM_EFAFFD27_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_99B8719D_Out_0 = _HeightMin2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4E5D833F_Out_0 = _HeightMax2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_3AF95429_Out_0 = float2(_Property_99B8719D_Out_0, _Property_4E5D833F_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_205C1A31_Out_0 = _HeightOffset2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_9F9AAF1B_Out_2;
                Unity_Add_float2(_Vector2_3AF95429_Out_0, (_Property_205C1A31_Out_0.xx), _Add_9F9AAF1B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_D6919CF_Out_3;
                Unity_Remap_float(_Split_EA4A8B31_B_3, float2 (0, 1), _Add_9F9AAF1B_Out_2, _Remap_D6919CF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_FF4F47A5_Out_2;
                Unity_Multiply_float(_Branch_7B7E6F83_Out_3, _Remap_D6919CF_Out_3, _Multiply_FF4F47A5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_930C89A1_Out_2;
                Unity_Multiply_float(_Split_1F16AC11_B_3, _Multiply_FF4F47A5_Out_2, _Multiply_930C89A1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_736BD634_Out_0 = _Height_Transition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_2075C0A0;
                float3 _HeightBlend_2075C0A0_OutVector4_1;
                SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_C587B50_Out_2.xyz), _Remap_EEF11503_Out_3, (_Multiply_55DF5EEA_Out_2.xyz), _Multiply_930C89A1_Out_2, _Property_736BD634_Out_0, _HeightBlend_2075C0A0, _HeightBlend_2075C0A0_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_947561E_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_72A8F044_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_7373B1C3;
                _PlanarNM_7373B1C3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_7373B1C3.uv0 = IN.uv0;
                float4 _PlanarNM_7373B1C3_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNM_7373B1C3, _PlanarNM_7373B1C3_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2F49B797_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_A3A6847B_Out_2;
                Unity_Multiply_float(_PlanarNM_7373B1C3_XZ_2, _Property_2F49B797_Out_0, _Multiply_A3A6847B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_1E4A4B5D_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_35AD8895_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_1E4A4B5D_Out_0.xy));
                float _SampleTexture2D_35AD8895_R_4 = _SampleTexture2D_35AD8895_RGBA_0.r;
                float _SampleTexture2D_35AD8895_G_5 = _SampleTexture2D_35AD8895_RGBA_0.g;
                float _SampleTexture2D_35AD8895_B_6 = _SampleTexture2D_35AD8895_RGBA_0.b;
                float _SampleTexture2D_35AD8895_A_7 = _SampleTexture2D_35AD8895_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_9504AB9D_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_7828E40F_Out_2;
                Unity_Multiply_float(_SampleTexture2D_35AD8895_A_7, _Property_9504AB9D_Out_0, _Multiply_7828E40F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_9A47E479_Out_3;
                Unity_Clamp_float(_Multiply_7828E40F_Out_2, 0, 1, _Clamp_9A47E479_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_C90B6C74;
                _PlanarNMn_C90B6C74.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_C90B6C74.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_C90B6C74.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_C90B6C74.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_C90B6C74.uv0 = IN.uv0;
                float4 _PlanarNMn_C90B6C74_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNMn_C90B6C74, _PlanarNMn_C90B6C74_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_3EFAC11B_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_46C809A8_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_C90B6C74_XZ_2.xyz), _Property_3EFAC11B_Out_0, _NormalStrength_46C809A8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_75A7E6E1;
                _PlanarNMn_75A7E6E1.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_75A7E6E1.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_75A7E6E1.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_75A7E6E1.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_75A7E6E1.uv0 = IN.uv0;
                float4 _PlanarNMn_75A7E6E1_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNMn_75A7E6E1, _PlanarNMn_75A7E6E1_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_18C7EECE_Out_0 = _Base2NormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_831CDFAC_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_75A7E6E1_XZ_2.xyz), _Property_18C7EECE_Out_0, _NormalStrength_831CDFAC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_EC733D35;
                float3 _HeightBlend_EC733D35_OutVector4_1;
                SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_46C809A8_Out_2, _Remap_EEF11503_Out_3, _NormalStrength_831CDFAC_Out_2, _Multiply_930C89A1_Out_2, _Property_736BD634_Out_0, _HeightBlend_EC733D35, _HeightBlend_EC733D35_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_41586C06;
                _PlanarNMn_41586C06.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_41586C06.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_41586C06.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_41586C06.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_41586C06.uv0 = IN.uv0;
                float4 _PlanarNMn_41586C06_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNMn_41586C06, _PlanarNMn_41586C06_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_497CF3E4_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_98B0A6A_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_41586C06_XZ_2.xyz), _Property_497CF3E4_Out_0, _NormalStrength_98B0A6A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_E816F564_R_1 = IN.WorldSpaceNormal[0];
                float _Split_E816F564_G_2 = IN.WorldSpaceNormal[1];
                float _Split_E816F564_B_3 = IN.WorldSpaceNormal[2];
                float _Split_E816F564_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_EBB9C74F_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_14B49BDA_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_99901F27_Out_2;
                Unity_Subtract_float(4, _Property_14B49BDA_Out_0, _Subtract_99901F27_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_6ECD57E8_Out_2;
                Unity_Divide_float(_Property_EBB9C74F_Out_0, _Subtract_99901F27_Out_2, _Divide_6ECD57E8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_ACF5CF89_Out_1;
                Unity_Absolute_float(_Divide_6ECD57E8_Out_2, _Absolute_ACF5CF89_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_195A75DF_Out_2;
                Unity_Power_float(_Absolute_ACF5CF89_Out_1, _Subtract_99901F27_Out_2, _Power_195A75DF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_31F7C969_Out_3;
                Unity_Clamp_float(_Power_195A75DF_Out_2, 0, 2, _Clamp_31F7C969_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5D2D037B_Out_2;
                Unity_Multiply_float(_Split_E816F564_G_2, _Clamp_31F7C969_Out_3, _Multiply_5D2D037B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_832431F7_Out_1;
                Unity_Saturate_float(_Multiply_5D2D037B_Out_2, _Saturate_832431F7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A5B13DB9_Out_3;
                Unity_Clamp_float(_Split_E816F564_G_2, 0, 0.9999, _Clamp_A5B13DB9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_4EC81755_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_9B40B768_Out_2;
                Unity_Divide_float(_Property_4EC81755_Out_0, 45, _Divide_9B40B768_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_A006C378_Out_1;
                Unity_OneMinus_float(_Divide_9B40B768_Out_2, _OneMinus_A006C378_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_B0272169_Out_2;
                Unity_Subtract_float(_Clamp_A5B13DB9_Out_3, _OneMinus_A006C378_Out_1, _Subtract_B0272169_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_1F415243_Out_3;
                Unity_Clamp_float(_Subtract_B0272169_Out_2, 0, 2, _Clamp_1F415243_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_DACFD30D_Out_2;
                Unity_Divide_float(1, _Divide_9B40B768_Out_2, _Divide_DACFD30D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F9549BCF_Out_2;
                Unity_Multiply_float(_Clamp_1F415243_Out_3, _Divide_DACFD30D_Out_2, _Multiply_F9549BCF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_791D03B7_Out_1;
                Unity_Absolute_float(_Multiply_F9549BCF_Out_2, _Absolute_791D03B7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_944A07C2_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_C2E0783A_Out_2;
                Unity_Power_float(_Absolute_791D03B7_Out_1, _Property_944A07C2_Out_0, _Power_C2E0783A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_69BC1F6D_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_4AF4FC6A_Out_1;
                Unity_OneMinus_float(_Property_69BC1F6D_Out_0, _OneMinus_4AF4FC6A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_7F8FD5EA_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_7F8FD5EA_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_7F8FD5EA_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_7F8FD5EA_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_B7F4D583_Out_2;
                Unity_Add_float(_OneMinus_4AF4FC6A_Out_1, _Split_7F8FD5EA_G_2, _Add_B7F4D583_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DF456C8_Out_2;
                Unity_Add_float(_Add_B7F4D583_Out_2, 1, _Add_DF456C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_DB90E782_Out_3;
                Unity_Clamp_float(_Add_DF456C8_Out_2, 0, 1, _Clamp_DB90E782_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_E7A2779D_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_8921CA8E_Out_2;
                Unity_Add_float(_Add_B7F4D583_Out_2, _Property_E7A2779D_Out_0, _Add_8921CA8E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_EC974C57_Out_2;
                Unity_Divide_float(_Add_8921CA8E_Out_2, _Add_B7F4D583_Out_2, _Divide_EC974C57_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_FA84DDCF_Out_1;
                Unity_OneMinus_float(_Divide_EC974C57_Out_2, _OneMinus_FA84DDCF_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_79EF52AF_Out_2;
                Unity_Add_float(_OneMinus_FA84DDCF_Out_1, -0.5, _Add_79EF52AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A6F2CA6C_Out_3;
                Unity_Clamp_float(_Add_79EF52AF_Out_2, 0, 1, _Clamp_A6F2CA6C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_C11529C0_Out_2;
                Unity_Add_float(_Clamp_DB90E782_Out_3, _Clamp_A6F2CA6C_Out_3, _Add_C11529C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_825E0B27_Out_3;
                Unity_Clamp_float(_Add_C11529C0_Out_2, 0, 1, _Clamp_825E0B27_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F8CC5F92_Out_2;
                Unity_Multiply_float(_Power_C2E0783A_Out_2, _Clamp_825E0B27_Out_3, _Multiply_F8CC5F92_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_9A6D78C0_Out_2;
                Unity_Multiply_float(_Saturate_832431F7_Out_1, _Multiply_F8CC5F92_Out_2, _Multiply_9A6D78C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_422E501D_Out_3;
                Unity_Lerp_float3(_HeightBlend_EC733D35_OutVector4_1, _NormalStrength_98B0A6A_Out_2, (_Multiply_9A6D78C0_Out_2.xxx), _Lerp_422E501D_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_49441AF_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_49441AF_Out_1 = normalize(mul(Transform_49441AF_transposeTangent, _Lerp_422E501D_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_6BFE2A44_R_1 = _Transform_49441AF_Out_1[0];
                float _Split_6BFE2A44_G_2 = _Transform_49441AF_Out_1[1];
                float _Split_6BFE2A44_B_3 = _Transform_49441AF_Out_1[2];
                float _Split_6BFE2A44_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_DCD9BE60_Out_2;
                Unity_Multiply_float(_Split_6BFE2A44_G_2, _Clamp_31F7C969_Out_3, _Multiply_DCD9BE60_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_59524B8D_Out_2;
                Unity_Multiply_float(_Clamp_31F7C969_Out_3, _Property_944A07C2_Out_0, _Multiply_59524B8D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_CF73EDD_Out_2;
                Unity_Multiply_float(_Multiply_59524B8D_Out_2, _Multiply_F8CC5F92_Out_2, _Multiply_CF73EDD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_6091EB57_Out_2;
                Unity_Multiply_float(_Multiply_DCD9BE60_Out_2, _Multiply_CF73EDD_Out_2, _Multiply_6091EB57_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_F10237A8;
                _PlanarNM_F10237A8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_F10237A8.uv0 = IN.uv0;
                float4 _PlanarNM_F10237A8_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNM_F10237A8, _PlanarNM_F10237A8_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_982C095D_R_1 = _PlanarNM_F10237A8_XZ_2[0];
                float _Split_982C095D_G_2 = _PlanarNM_F10237A8_XZ_2[1];
                float _Split_982C095D_B_3 = _PlanarNM_F10237A8_XZ_2[2];
                float _Split_982C095D_A_4 = _PlanarNM_F10237A8_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_C3EF9D20_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_E3A09D98_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_C90CCB0_Out_0 = float2(_Property_C3EF9D20_Out_0, _Property_E3A09D98_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_69DDD5BF_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_6794A75_Out_2;
                Unity_Add_float2(_Vector2_C90CCB0_Out_0, (_Property_69DDD5BF_Out_0.xx), _Add_6794A75_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_42D24C67_Out_3;
                Unity_Remap_float(_Split_982C095D_B_3, float2 (0, 1), _Add_6794A75_Out_2, _Remap_42D24C67_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_3EDCB3E3_Out_2;
                Unity_Multiply_float(_Multiply_6091EB57_Out_2, _Remap_42D24C67_Out_3, _Multiply_3EDCB3E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_7FB2649_Out_2;
                Unity_Multiply_float(_Split_1F16AC11_G_2, _Multiply_3EDCB3E3_Out_2, _Multiply_7FB2649_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_B924FC4D_Out_1;
                Unity_Saturate_float(_Multiply_7FB2649_Out_2, _Saturate_B924FC4D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_EE37C6A7_Out_2;
                Unity_Multiply_float(_Clamp_9A47E479_Out_3, _Saturate_B924FC4D_Out_1, _Multiply_EE37C6A7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_7E3320FD_Out_0 = _Multiply_EE37C6A7_Out_2;
                #else
                float _UseDynamicCoverTStaticMaskF_7E3320FD_Out_0 = _Clamp_9A47E479_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_493CF2FB_Out_3;
                Unity_Lerp_float3(_HeightBlend_2075C0A0_OutVector4_1, (_Multiply_A3A6847B_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_7E3320FD_Out_0.xxx), _Lerp_493CF2FB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_6E1772E4_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_FFF6BF72_Out_2;
                Unity_Multiply_float((_Property_6E1772E4_Out_0.xyz), _Lerp_493CF2FB_Out_3, _Multiply_FFF6BF72_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_E96D8F6B_Out_1;
                Unity_OneMinus_float(_Split_1F16AC11_R_1, _OneMinus_E96D8F6B_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_DA672D44_Out_3;
                Unity_Lerp_float3(_Lerp_493CF2FB_Out_3, _Multiply_FFF6BF72_Out_2, (_OneMinus_E96D8F6B_Out_1.xxx), _Lerp_DA672D44_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_6530ACB3_R_1 = _PlanarNM_C512A3B9_XZ_2[0];
                float _Split_6530ACB3_G_2 = _PlanarNM_C512A3B9_XZ_2[1];
                float _Split_6530ACB3_B_3 = _PlanarNM_C512A3B9_XZ_2[2];
                float _Split_6530ACB3_A_4 = _PlanarNM_C512A3B9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_91A5D9D0_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_DA672D44_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Alpha = _Split_6530ACB3_A_4;
                surface.AlphaClipThreshold = _Property_91A5D9D0_Out_0;
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
            float _Invert_Layer_Mask;
            float _Height_Transition;
            float _HeightMin;
            float _HeightMax;
            float _HeightOffset;
            float _HeightMin2;
            float _HeightMax2;
            float _HeightOffset2;
            float4 _Base2Color;
            float4 _Base2TilingOffset;
            float _Base2UsePlanarUV;
            float _Base2NormalScale;
            float _Base2Metallic;
            float _Base2SmoothnessRemapMin;
            float _Base2SmoothnessRemapMax;
            float _Base2AORemapMin;
            float _Base2AORemapMax;
            float _CoverMaskPower;
            float _Cover_Amount;
            float _Cover_Amount_Grow_Speed;
            float _Cover_Max_Angle;
            float _Cover_Min_Height;
            float _Cover_Min_Height_Blending;
            float4 _CoverBaseColor;
            float4 _CoverTilingOffset;
            float _CoverUsePlanarUV;
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
            float4 _WetColor;
            float _WetSmoothness;
            CBUFFER_END
            TEXTURE2D(_BaseColorMap); SAMPLER(sampler_BaseColorMap); float4 _BaseColorMap_TexelSize;
            TEXTURE2D(_BaseNormalMap); SAMPLER(sampler_BaseNormalMap); float4 _BaseNormalMap_TexelSize;
            TEXTURE2D(_BaseMaskMap); SAMPLER(sampler_BaseMaskMap); float4 _BaseMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_Base2ColorMap); SAMPLER(sampler_Base2ColorMap); float4 _Base2ColorMap_TexelSize;
            TEXTURE2D(_Base2NormalMap); SAMPLER(sampler_Base2NormalMap); float4 _Base2NormalMap_TexelSize;
            TEXTURE2D(_Base2MaskMap); SAMPLER(sampler_Base2MaskMap); float4 _Base2MaskMap_TexelSize;
            TEXTURE2D(_CoverMaskA); SAMPLER(sampler_CoverMaskA); float4 _CoverMaskA_TexelSize;
            TEXTURE2D(_CoverBaseColorMap); SAMPLER(sampler_CoverBaseColorMap); float4 _CoverBaseColorMap_TexelSize;
            TEXTURE2D(_CoverNormalMap); SAMPLER(sampler_CoverNormalMap); float4 _CoverNormalMap_TexelSize;
            TEXTURE2D(_CoverMaskMap); SAMPLER(sampler_CoverMaskMap); float4 _CoverMaskMap_TexelSize;
            SAMPLER(_SampleTexture2D_AF934D9A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_2B947FAD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_35AD8895_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Add_float2(float2 A, float2 B, out float2 Out)
            {
                Out = A + B;
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
            
            void Unity_OneMinus_float(float In, out float Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Branch_float(float Predicate, float True, float False, out float Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Maximum_float(float A, float B, out float Out)
            {
                Out = max(A, B);
            }
            
            void Unity_Subtract_float(float A, float B, out float Out)
            {
                Out = A - B;
            }
            
            void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A + B;
            }
            
            void Unity_Add_float(float A, float B, out float Out)
            {
                Out = A + B;
            }
            
            void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
            {
                Out = A / B;
            }
            
            struct Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135
            {
            };
            
            void SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(float3 Vector3_88EEBB5E, float Vector1_DA0A37FA, float3 Vector3_79AA92F, float Vector1_F7E83F1E, float Vector1_1C9222A6, Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 IN, out float3 OutVector4_1)
            {
                float3 _Property_CE7501EE_Out_0 = Vector3_88EEBB5E;
                float _Property_21A77CD2_Out_0 = Vector1_DA0A37FA;
                float _Property_B0F6C734_Out_0 = Vector1_DA0A37FA;
                float _Property_F32C0509_Out_0 = Vector1_F7E83F1E;
                float _Maximum_2C42CE33_Out_2;
                Unity_Maximum_float(_Property_B0F6C734_Out_0, _Property_F32C0509_Out_0, _Maximum_2C42CE33_Out_2);
                float _Property_FBC3A76E_Out_0 = Vector1_1C9222A6;
                float _Subtract_5E32B1F2_Out_2;
                Unity_Subtract_float(_Maximum_2C42CE33_Out_2, _Property_FBC3A76E_Out_0, _Subtract_5E32B1F2_Out_2);
                float _Subtract_AE0D0FB3_Out_2;
                Unity_Subtract_float(_Property_21A77CD2_Out_0, _Subtract_5E32B1F2_Out_2, _Subtract_AE0D0FB3_Out_2);
                float _Maximum_B94A8EBA_Out_2;
                Unity_Maximum_float(_Subtract_AE0D0FB3_Out_2, 0, _Maximum_B94A8EBA_Out_2);
                float3 _Multiply_6D1F195B_Out_2;
                Unity_Multiply_float(_Property_CE7501EE_Out_0, (_Maximum_B94A8EBA_Out_2.xxx), _Multiply_6D1F195B_Out_2);
                float3 _Property_94C053EA_Out_0 = Vector3_79AA92F;
                float _Property_B5C791CC_Out_0 = Vector1_F7E83F1E;
                float _Subtract_5DDA2278_Out_2;
                Unity_Subtract_float(_Property_B5C791CC_Out_0, _Subtract_5E32B1F2_Out_2, _Subtract_5DDA2278_Out_2);
                float _Maximum_3087B5D0_Out_2;
                Unity_Maximum_float(_Subtract_5DDA2278_Out_2, 0, _Maximum_3087B5D0_Out_2);
                float3 _Multiply_61466A85_Out_2;
                Unity_Multiply_float(_Property_94C053EA_Out_0, (_Maximum_3087B5D0_Out_2.xxx), _Multiply_61466A85_Out_2);
                float3 _Add_87880A51_Out_2;
                Unity_Add_float3(_Multiply_6D1F195B_Out_2, _Multiply_61466A85_Out_2, _Add_87880A51_Out_2);
                float _Add_43856DBF_Out_2;
                Unity_Add_float(_Maximum_B94A8EBA_Out_2, _Maximum_3087B5D0_Out_2, _Add_43856DBF_Out_2);
                float _Maximum_47B2BE36_Out_2;
                Unity_Maximum_float(_Add_43856DBF_Out_2, 1E-05, _Maximum_47B2BE36_Out_2);
                float3 _Divide_593AB2EB_Out_2;
                Unity_Divide_float3(_Add_87880A51_Out_2, (_Maximum_47B2BE36_Out_2.xxx), _Divide_593AB2EB_Out_2);
                OutVector4_1 = _Divide_593AB2EB_Out_2;
            }
            
            void Unity_Clamp_float(float In, float Min, float Max, out float Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Sign_float3(float3 In, out float3 Out)
            {
                Out = sign(In);
            }
            
            void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
            {
                Out = A * B;
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
            
            void Unity_Absolute_float(float In, out float Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_float(float A, float B, out float Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Saturate_float(float In, out float Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
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
                Bindings_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b _NMObjectVSProIndirect_E5D3779D;
                float3 _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
                SG_NMObjectVSProIndirect_0cfe1e4f145944241ab304331e53c93b(IN.ObjectSpacePosition, _NMObjectVSProIndirect_E5D3779D, _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1);
                #endif
                description.VertexPosition = _NMObjectVSProIndirect_E5D3779D_ObjectSpacePosition_1;
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
                float4 _Property_A6DEAB8F_Out_0 = _BaseTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_C3635EE5_Out_0 = _BaseUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_C512A3B9;
                _PlanarNM_C512A3B9.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_C512A3B9.uv0 = IN.uv0;
                float4 _PlanarNM_C512A3B9_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseColorMap, sampler_BaseColorMap), _BaseColorMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_C512A3B9, _PlanarNM_C512A3B9_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2FD303FC_Out_0 = _BaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_C587B50_Out_2;
                Unity_Multiply_float(_PlanarNM_C512A3B9_XZ_2, _Property_2FD303FC_Out_0, _Multiply_C587B50_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_3D868FEF;
                _PlanarNM_3D868FEF.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_3D868FEF.uv0 = IN.uv0;
                float4 _PlanarNM_3D868FEF_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_BaseMaskMap, sampler_BaseMaskMap), _BaseMaskMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNM_3D868FEF, _PlanarNM_3D868FEF_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_1925DEC3_R_1 = _PlanarNM_3D868FEF_XZ_2[0];
                float _Split_1925DEC3_G_2 = _PlanarNM_3D868FEF_XZ_2[1];
                float _Split_1925DEC3_B_3 = _PlanarNM_3D868FEF_XZ_2[2];
                float _Split_1925DEC3_A_4 = _PlanarNM_3D868FEF_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_FC207EAA_Out_0 = _HeightMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_EA6A8126_Out_0 = _HeightMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_AE7661E9_Out_0 = float2(_Property_FC207EAA_Out_0, _Property_EA6A8126_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_84099320_Out_0 = _HeightOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_DC3BF6BC_Out_2;
                Unity_Add_float2(_Vector2_AE7661E9_Out_0, (_Property_84099320_Out_0.xx), _Add_DC3BF6BC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_EEF11503_Out_3;
                Unity_Remap_float(_Split_1925DEC3_B_3, float2 (0, 1), _Add_DC3BF6BC_Out_2, _Remap_EEF11503_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2D1893AC_Out_0 = _Base2TilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_225AB14B_Out_0 = _Base2UsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_2D1D7349;
                _PlanarNM_2D1D7349.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_2D1D7349.uv0 = IN.uv0;
                float4 _PlanarNM_2D1D7349_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2ColorMap, sampler_Base2ColorMap), _Base2ColorMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNM_2D1D7349, _PlanarNM_2D1D7349_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_C338F812_Out_0 = _Base2Color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_55DF5EEA_Out_2;
                Unity_Multiply_float(_PlanarNM_2D1D7349_XZ_2, _Property_C338F812_Out_0, _Multiply_55DF5EEA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_1F16AC11_R_1 = IN.VertexColor[0];
                float _Split_1F16AC11_G_2 = IN.VertexColor[1];
                float _Split_1F16AC11_B_3 = IN.VertexColor[2];
                float _Split_1F16AC11_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_45C5314D_Out_0 = _Invert_Layer_Mask;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_2B947FAD_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, IN.uv0.xy);
                float _SampleTexture2D_2B947FAD_R_4 = _SampleTexture2D_2B947FAD_RGBA_0.r;
                float _SampleTexture2D_2B947FAD_G_5 = _SampleTexture2D_2B947FAD_RGBA_0.g;
                float _SampleTexture2D_2B947FAD_B_6 = _SampleTexture2D_2B947FAD_RGBA_0.b;
                float _SampleTexture2D_2B947FAD_A_7 = _SampleTexture2D_2B947FAD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_6D8E0CA7_Out_1;
                Unity_OneMinus_float(_SampleTexture2D_2B947FAD_R_4, _OneMinus_6D8E0CA7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Branch_7B7E6F83_Out_3;
                Unity_Branch_float(_Property_45C5314D_Out_0, _OneMinus_6D8E0CA7_Out_1, _SampleTexture2D_2B947FAD_R_4, _Branch_7B7E6F83_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_EFAFFD27;
                _PlanarNM_EFAFFD27.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_EFAFFD27.uv0 = IN.uv0;
                float4 _PlanarNM_EFAFFD27_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_Base2MaskMap, sampler_Base2MaskMap), _Base2MaskMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNM_EFAFFD27, _PlanarNM_EFAFFD27_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_EA4A8B31_R_1 = _PlanarNM_EFAFFD27_XZ_2[0];
                float _Split_EA4A8B31_G_2 = _PlanarNM_EFAFFD27_XZ_2[1];
                float _Split_EA4A8B31_B_3 = _PlanarNM_EFAFFD27_XZ_2[2];
                float _Split_EA4A8B31_A_4 = _PlanarNM_EFAFFD27_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_99B8719D_Out_0 = _HeightMin2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_4E5D833F_Out_0 = _HeightMax2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Vector2_3AF95429_Out_0 = float2(_Property_99B8719D_Out_0, _Property_4E5D833F_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_205C1A31_Out_0 = _HeightOffset2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 _Add_9F9AAF1B_Out_2;
                Unity_Add_float2(_Vector2_3AF95429_Out_0, (_Property_205C1A31_Out_0.xx), _Add_9F9AAF1B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Remap_D6919CF_Out_3;
                Unity_Remap_float(_Split_EA4A8B31_B_3, float2 (0, 1), _Add_9F9AAF1B_Out_2, _Remap_D6919CF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_FF4F47A5_Out_2;
                Unity_Multiply_float(_Branch_7B7E6F83_Out_3, _Remap_D6919CF_Out_3, _Multiply_FF4F47A5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_930C89A1_Out_2;
                Unity_Multiply_float(_Split_1F16AC11_B_3, _Multiply_FF4F47A5_Out_2, _Multiply_930C89A1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_736BD634_Out_0 = _Height_Transition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_2075C0A0;
                float3 _HeightBlend_2075C0A0_OutVector4_1;
                SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135((_Multiply_C587B50_Out_2.xyz), _Remap_EEF11503_Out_3, (_Multiply_55DF5EEA_Out_2.xyz), _Multiply_930C89A1_Out_2, _Property_736BD634_Out_0, _HeightBlend_2075C0A0, _HeightBlend_2075C0A0_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_947561E_Out_0 = _CoverTilingOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_72A8F044_Out_0 = _CoverUsePlanarUV;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_7373B1C3;
                _PlanarNM_7373B1C3.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_7373B1C3.uv0 = IN.uv0;
                float4 _PlanarNM_7373B1C3_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverBaseColorMap, sampler_CoverBaseColorMap), _CoverBaseColorMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNM_7373B1C3, _PlanarNM_7373B1C3_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_2F49B797_Out_0 = _CoverBaseColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Multiply_A3A6847B_Out_2;
                Unity_Multiply_float(_PlanarNM_7373B1C3_XZ_2, _Property_2F49B797_Out_0, _Multiply_A3A6847B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _UV_1E4A4B5D_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _SampleTexture2D_35AD8895_RGBA_0 = SAMPLE_TEXTURE2D(_CoverMaskA, sampler_CoverMaskA, (_UV_1E4A4B5D_Out_0.xy));
                float _SampleTexture2D_35AD8895_R_4 = _SampleTexture2D_35AD8895_RGBA_0.r;
                float _SampleTexture2D_35AD8895_G_5 = _SampleTexture2D_35AD8895_RGBA_0.g;
                float _SampleTexture2D_35AD8895_B_6 = _SampleTexture2D_35AD8895_RGBA_0.b;
                float _SampleTexture2D_35AD8895_A_7 = _SampleTexture2D_35AD8895_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_9504AB9D_Out_0 = _CoverMaskPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Multiply_7828E40F_Out_2;
                Unity_Multiply_float(_SampleTexture2D_35AD8895_A_7, _Property_9504AB9D_Out_0, _Multiply_7828E40F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Clamp_9A47E479_Out_3;
                Unity_Clamp_float(_Multiply_7828E40F_Out_2, 0, 1, _Clamp_9A47E479_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_C90B6C74;
                _PlanarNMn_C90B6C74.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_C90B6C74.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_C90B6C74.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_C90B6C74.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_C90B6C74.uv0 = IN.uv0;
                float4 _PlanarNMn_C90B6C74_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_BaseNormalMap, sampler_BaseNormalMap), _BaseNormalMap_TexelSize, _Property_A6DEAB8F_Out_0, _Property_C3635EE5_Out_0, _PlanarNMn_C90B6C74, _PlanarNMn_C90B6C74_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_3EFAC11B_Out_0 = _BaseNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_46C809A8_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_C90B6C74_XZ_2.xyz), _Property_3EFAC11B_Out_0, _NormalStrength_46C809A8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_75A7E6E1;
                _PlanarNMn_75A7E6E1.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_75A7E6E1.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_75A7E6E1.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_75A7E6E1.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_75A7E6E1.uv0 = IN.uv0;
                float4 _PlanarNMn_75A7E6E1_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_Base2NormalMap, sampler_Base2NormalMap), _Base2NormalMap_TexelSize, _Property_2D1893AC_Out_0, _Property_225AB14B_Out_0, _PlanarNMn_75A7E6E1, _PlanarNMn_75A7E6E1_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_18C7EECE_Out_0 = _Base2NormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_831CDFAC_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_75A7E6E1_XZ_2.xyz), _Property_18C7EECE_Out_0, _NormalStrength_831CDFAC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135 _HeightBlend_EC733D35;
                float3 _HeightBlend_EC733D35_OutVector4_1;
                SG_HeightBlend_d15b6fb865d3b6d4ebc1fd476c3ad135(_NormalStrength_46C809A8_Out_2, _Remap_EEF11503_Out_3, _NormalStrength_831CDFAC_Out_2, _Multiply_930C89A1_Out_2, _Property_736BD634_Out_0, _HeightBlend_EC733D35, _HeightBlend_EC733D35_OutVector4_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8 _PlanarNMn_41586C06;
                _PlanarNMn_41586C06.WorldSpaceNormal = IN.WorldSpaceNormal;
                _PlanarNMn_41586C06.WorldSpaceTangent = IN.WorldSpaceTangent;
                _PlanarNMn_41586C06.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
                _PlanarNMn_41586C06.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNMn_41586C06.uv0 = IN.uv0;
                float4 _PlanarNMn_41586C06_XZ_2;
                SG_PlanarNMn_1b93a87456f9d4c419321d0cd92bd6c8(TEXTURE2D_ARGS(_CoverNormalMap, sampler_CoverNormalMap), _CoverNormalMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNMn_41586C06, _PlanarNMn_41586C06_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_497CF3E4_Out_0 = _CoverNormalBlendHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _NormalStrength_98B0A6A_Out_2;
                Unity_NormalStrength_float((_PlanarNMn_41586C06_XZ_2.xyz), _Property_497CF3E4_Out_0, _NormalStrength_98B0A6A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_E816F564_R_1 = IN.WorldSpaceNormal[0];
                float _Split_E816F564_G_2 = IN.WorldSpaceNormal[1];
                float _Split_E816F564_B_3 = IN.WorldSpaceNormal[2];
                float _Split_E816F564_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_EBB9C74F_Out_0 = _Cover_Amount;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_14B49BDA_Out_0 = _Cover_Amount_Grow_Speed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_99901F27_Out_2;
                Unity_Subtract_float(4, _Property_14B49BDA_Out_0, _Subtract_99901F27_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_6ECD57E8_Out_2;
                Unity_Divide_float(_Property_EBB9C74F_Out_0, _Subtract_99901F27_Out_2, _Divide_6ECD57E8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_ACF5CF89_Out_1;
                Unity_Absolute_float(_Divide_6ECD57E8_Out_2, _Absolute_ACF5CF89_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_195A75DF_Out_2;
                Unity_Power_float(_Absolute_ACF5CF89_Out_1, _Subtract_99901F27_Out_2, _Power_195A75DF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_31F7C969_Out_3;
                Unity_Clamp_float(_Power_195A75DF_Out_2, 0, 2, _Clamp_31F7C969_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_5D2D037B_Out_2;
                Unity_Multiply_float(_Split_E816F564_G_2, _Clamp_31F7C969_Out_3, _Multiply_5D2D037B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_832431F7_Out_1;
                Unity_Saturate_float(_Multiply_5D2D037B_Out_2, _Saturate_832431F7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A5B13DB9_Out_3;
                Unity_Clamp_float(_Split_E816F564_G_2, 0, 0.9999, _Clamp_A5B13DB9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_4EC81755_Out_0 = _Cover_Max_Angle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_9B40B768_Out_2;
                Unity_Divide_float(_Property_4EC81755_Out_0, 45, _Divide_9B40B768_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_A006C378_Out_1;
                Unity_OneMinus_float(_Divide_9B40B768_Out_2, _OneMinus_A006C378_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Subtract_B0272169_Out_2;
                Unity_Subtract_float(_Clamp_A5B13DB9_Out_3, _OneMinus_A006C378_Out_1, _Subtract_B0272169_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_1F415243_Out_3;
                Unity_Clamp_float(_Subtract_B0272169_Out_2, 0, 2, _Clamp_1F415243_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_DACFD30D_Out_2;
                Unity_Divide_float(1, _Divide_9B40B768_Out_2, _Divide_DACFD30D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F9549BCF_Out_2;
                Unity_Multiply_float(_Clamp_1F415243_Out_3, _Divide_DACFD30D_Out_2, _Multiply_F9549BCF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Absolute_791D03B7_Out_1;
                Unity_Absolute_float(_Multiply_F9549BCF_Out_2, _Absolute_791D03B7_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_944A07C2_Out_0 = _CoverHardness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Power_C2E0783A_Out_2;
                Unity_Power_float(_Absolute_791D03B7_Out_1, _Property_944A07C2_Out_0, _Power_C2E0783A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_69BC1F6D_Out_0 = _Cover_Min_Height;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_4AF4FC6A_Out_1;
                Unity_OneMinus_float(_Property_69BC1F6D_Out_0, _OneMinus_4AF4FC6A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_7F8FD5EA_R_1 = IN.AbsoluteWorldSpacePosition[0];
                float _Split_7F8FD5EA_G_2 = IN.AbsoluteWorldSpacePosition[1];
                float _Split_7F8FD5EA_B_3 = IN.AbsoluteWorldSpacePosition[2];
                float _Split_7F8FD5EA_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_B7F4D583_Out_2;
                Unity_Add_float(_OneMinus_4AF4FC6A_Out_1, _Split_7F8FD5EA_G_2, _Add_B7F4D583_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_DF456C8_Out_2;
                Unity_Add_float(_Add_B7F4D583_Out_2, 1, _Add_DF456C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_DB90E782_Out_3;
                Unity_Clamp_float(_Add_DF456C8_Out_2, 0, 1, _Clamp_DB90E782_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_E7A2779D_Out_0 = _Cover_Min_Height_Blending;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_8921CA8E_Out_2;
                Unity_Add_float(_Add_B7F4D583_Out_2, _Property_E7A2779D_Out_0, _Add_8921CA8E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Divide_EC974C57_Out_2;
                Unity_Divide_float(_Add_8921CA8E_Out_2, _Add_B7F4D583_Out_2, _Divide_EC974C57_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _OneMinus_FA84DDCF_Out_1;
                Unity_OneMinus_float(_Divide_EC974C57_Out_2, _OneMinus_FA84DDCF_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_79EF52AF_Out_2;
                Unity_Add_float(_OneMinus_FA84DDCF_Out_1, -0.5, _Add_79EF52AF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_A6F2CA6C_Out_3;
                Unity_Clamp_float(_Add_79EF52AF_Out_2, 0, 1, _Clamp_A6F2CA6C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Add_C11529C0_Out_2;
                Unity_Add_float(_Clamp_DB90E782_Out_3, _Clamp_A6F2CA6C_Out_3, _Add_C11529C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Clamp_825E0B27_Out_3;
                Unity_Clamp_float(_Add_C11529C0_Out_2, 0, 1, _Clamp_825E0B27_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_F8CC5F92_Out_2;
                Unity_Multiply_float(_Power_C2E0783A_Out_2, _Clamp_825E0B27_Out_3, _Multiply_F8CC5F92_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_9A6D78C0_Out_2;
                Unity_Multiply_float(_Saturate_832431F7_Out_1, _Multiply_F8CC5F92_Out_2, _Multiply_9A6D78C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3 _Lerp_422E501D_Out_3;
                Unity_Lerp_float3(_HeightBlend_EC733D35_OutVector4_1, _NormalStrength_98B0A6A_Out_2, (_Multiply_9A6D78C0_Out_2.xxx), _Lerp_422E501D_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float3x3 Transform_49441AF_transposeTangent = transpose(float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal));
                float3 _Transform_49441AF_Out_1 = normalize(mul(Transform_49441AF_transposeTangent, _Lerp_422E501D_Out_3.xyz).xyz);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_6BFE2A44_R_1 = _Transform_49441AF_Out_1[0];
                float _Split_6BFE2A44_G_2 = _Transform_49441AF_Out_1[1];
                float _Split_6BFE2A44_B_3 = _Transform_49441AF_Out_1[2];
                float _Split_6BFE2A44_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_DCD9BE60_Out_2;
                Unity_Multiply_float(_Split_6BFE2A44_G_2, _Clamp_31F7C969_Out_3, _Multiply_DCD9BE60_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_59524B8D_Out_2;
                Unity_Multiply_float(_Clamp_31F7C969_Out_3, _Property_944A07C2_Out_0, _Multiply_59524B8D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_CF73EDD_Out_2;
                Unity_Multiply_float(_Multiply_59524B8D_Out_2, _Multiply_F8CC5F92_Out_2, _Multiply_CF73EDD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_6091EB57_Out_2;
                Unity_Multiply_float(_Multiply_DCD9BE60_Out_2, _Multiply_CF73EDD_Out_2, _Multiply_6091EB57_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                Bindings_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6 _PlanarNM_F10237A8;
                _PlanarNM_F10237A8.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
                _PlanarNM_F10237A8.uv0 = IN.uv0;
                float4 _PlanarNM_F10237A8_XZ_2;
                SG_PlanarNM_c0f081da9c567704ea36e7dd38cedcf6(TEXTURE2D_ARGS(_CoverMaskMap, sampler_CoverMaskMap), _CoverMaskMap_TexelSize, _Property_947561E_Out_0, _Property_72A8F044_Out_0, _PlanarNM_F10237A8, _PlanarNM_F10237A8_XZ_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Split_982C095D_R_1 = _PlanarNM_F10237A8_XZ_2[0];
                float _Split_982C095D_G_2 = _PlanarNM_F10237A8_XZ_2[1];
                float _Split_982C095D_B_3 = _PlanarNM_F10237A8_XZ_2[2];
                float _Split_982C095D_A_4 = _PlanarNM_F10237A8_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_C3EF9D20_Out_0 = _CoverHeightMapMin;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_E3A09D98_Out_0 = _CoverHeightMapMax;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Vector2_C90CCB0_Out_0 = float2(_Property_C3EF9D20_Out_0, _Property_E3A09D98_Out_0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Property_69DDD5BF_Out_0 = _CoverHeightMapOffset;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float2 _Add_6794A75_Out_2;
                Unity_Add_float2(_Vector2_C90CCB0_Out_0, (_Property_69DDD5BF_Out_0.xx), _Add_6794A75_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Remap_42D24C67_Out_3;
                Unity_Remap_float(_Split_982C095D_B_3, float2 (0, 1), _Add_6794A75_Out_2, _Remap_42D24C67_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_3EDCB3E3_Out_2;
                Unity_Multiply_float(_Multiply_6091EB57_Out_2, _Remap_42D24C67_Out_3, _Multiply_3EDCB3E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_7FB2649_Out_2;
                Unity_Multiply_float(_Split_1F16AC11_G_2, _Multiply_3EDCB3E3_Out_2, _Multiply_7FB2649_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Saturate_B924FC4D_Out_1;
                Unity_Saturate_float(_Multiply_7FB2649_Out_2, _Saturate_B924FC4D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                float _Multiply_EE37C6A7_Out_2;
                Unity_Multiply_float(_Clamp_9A47E479_Out_3, _Saturate_B924FC4D_Out_1, _Multiply_EE37C6A7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_USEDYNAMICCOVERTSTATICMASKF_ON)
                float _UseDynamicCoverTStaticMaskF_7E3320FD_Out_0 = _Multiply_EE37C6A7_Out_2;
                #else
                float _UseDynamicCoverTStaticMaskF_7E3320FD_Out_0 = _Clamp_9A47E479_Out_3;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_493CF2FB_Out_3;
                Unity_Lerp_float3(_HeightBlend_2075C0A0_OutVector4_1, (_Multiply_A3A6847B_Out_2.xyz), (_UseDynamicCoverTStaticMaskF_7E3320FD_Out_0.xxx), _Lerp_493CF2FB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 _Property_6E1772E4_Out_0 = _WetColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Multiply_FFF6BF72_Out_2;
                Unity_Multiply_float((_Property_6E1772E4_Out_0.xyz), _Lerp_493CF2FB_Out_3, _Multiply_FFF6BF72_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _OneMinus_E96D8F6B_Out_1;
                Unity_OneMinus_float(_Split_1F16AC11_R_1, _OneMinus_E96D8F6B_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 _Lerp_DA672D44_Out_3;
                Unity_Lerp_float3(_Lerp_493CF2FB_Out_3, _Multiply_FFF6BF72_Out_2, (_OneMinus_E96D8F6B_Out_1.xxx), _Lerp_DA672D44_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Split_6530ACB3_R_1 = _PlanarNM_C512A3B9_XZ_2[0];
                float _Split_6530ACB3_G_2 = _PlanarNM_C512A3B9_XZ_2[1];
                float _Split_6530ACB3_B_3 = _PlanarNM_C512A3B9_XZ_2[2];
                float _Split_6530ACB3_A_4 = _PlanarNM_C512A3B9_XZ_2[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float _Property_91A5D9D0_Out_0 = _AlphaCutoff;
                #endif
                surface.Albedo = _Lerp_DA672D44_Out_3;
                surface.Alpha = _Split_6530ACB3_A_4;
                surface.AlphaClipThreshold = _Property_91A5D9D0_Out_0;
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
