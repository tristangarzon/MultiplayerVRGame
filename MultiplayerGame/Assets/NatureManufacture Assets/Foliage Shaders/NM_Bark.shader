Shader "NatureManufacture/URP/Foliage/Bark"
{
    Properties
    {
        _TrunkBaseColor("Trunk Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_TrunkBaseColorMap("Trunk Base Map", 2D) = "white" {}
        _TrunkTilingOffset("Trunk Tiling and Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_TrunkNormalMap("Trunk Normal Map", 2D) = "bump" {}
        _TrunkNormalScale("Trunk Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_TrunkMaskMap("Trunk Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
        _TrunkMetallic("Trunk Metallic", Range(0, 1)) = 1
        _TrunkAORemapMin("Trunk AO Remap Min", Range(0, 1)) = 0
        _TrunkAORemapMax("Trunk AO Remap Max", Range(0, 1)) = 1
        _TrunkSmoothnessRemapMin("Trunk Smoothness Remap Min", Range(0, 1)) = 0
        _TrunkSmoothnessRemapMax("Trunk Smoothness Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_LayerMask("Bark Blend Mask(A)", 2D) = "black" {}
        _BarkBlendMaskTilingOffset("Bark Blend Mask Tiling Offset", Vector) = (1, 1, 0, 0)
        _BarkBaseColor("Bark Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_BarkBaseColorMap("Bark Base Map", 2D) = "white" {}
        [ToggleUI]_BarkUseUV3("Bark Use UV3", Float) = 1
        _BarkTilingOffset("Bark Tiling and Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_BarkNormalMap("Bark Normal Map", 2D) = "bump" {}
        _BarkNormalScale("Bark Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_BarkMaskMap("Bark Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
        _BarkMetallic("Bark Metallic", Range(0, 1)) = 1
        _BarkSmoothnessRemapMin("Bark Smoothness Remap Min", Range(0, 1)) = 0
        _BarkSmoothnessRemapMax("Bark Smoothness Remap Max", Range(0, 1)) = 1
        _BarkAORemapMin("Bark AO Remap Min", Range(0, 1)) = 0
        _BarkAORemapMax("Bark AO Remap Max", Range(0, 1)) = 1
        _Stiffness("Wind Stiffness", Float) = 0
        _InitialBend("Wind Initial Bend", Float) = 0
        _Drag("Wind Drag", Float) = 0
        _NewNormal("Mesh Normal Multiply", Vector) = (0, 0, 0, 0)
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
            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define VARYINGS_NEED_POSITION_WS 
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
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
            float4 _TrunkBaseColor;
            float4 _TrunkTilingOffset;
            float _TrunkNormalScale;
            float _TrunkMetallic;
            float _TrunkAORemapMin;
            float _TrunkAORemapMax;
            float _TrunkSmoothnessRemapMin;
            float _TrunkSmoothnessRemapMax;
            float4 _BarkBlendMaskTilingOffset;
            float4 _BarkBaseColor;
            float _BarkUseUV3;
            float4 _BarkTilingOffset;
            float _BarkNormalScale;
            float _BarkMetallic;
            float _BarkSmoothnessRemapMin;
            float _BarkSmoothnessRemapMax;
            float _BarkAORemapMin;
            float _BarkAORemapMax;
            float _Stiffness;
            float _InitialBend;
            float _Drag;
            float4 _NewNormal;
            CBUFFER_END
            TEXTURE2D(_TrunkBaseColorMap); SAMPLER(sampler_TrunkBaseColorMap); float4 _TrunkBaseColorMap_TexelSize;
            TEXTURE2D(_TrunkNormalMap); SAMPLER(sampler_TrunkNormalMap); float4 _TrunkNormalMap_TexelSize;
            TEXTURE2D(_TrunkMaskMap); SAMPLER(sampler_TrunkMaskMap); float4 _TrunkMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_BarkBaseColorMap); SAMPLER(sampler_BarkBaseColorMap); float4 _BarkBaseColorMap_TexelSize;
            TEXTURE2D(_BarkNormalMap); SAMPLER(sampler_BarkNormalMap); float4 _BarkNormalMap_TexelSize;
            TEXTURE2D(_BarkMaskMap); SAMPLER(sampler_BarkMaskMap); float4 _BarkMaskMap_TexelSize;
            SAMPLER(_SampleTexture2D_B919BA28_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_7E4BB55F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_BCB513F9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEF8D028_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D27E02B1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_709ACF8B_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8D305B2_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // 02092042f8fbe23da7886005ee29c06a
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
            {
            };
            
            void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
            // cffff589f98579275da61b43e2de268d
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
            
            void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
            {
                Out = UV * Tiling + Offset;
            }
            
            void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
            {
                Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Multiply_float(float A, float B, out float Out)
            {
                Out = A * B;
            }
            
            void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
            {
                Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
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
                Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_6AFECCFE;
                float3 _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1;
                SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_6AFECCFE, _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1);
                float3 _CustomFunction_CE35C910_vertex_3;
                float3 _CustomFunction_CE35C910_normal_4;
                CalculateWind_float(_NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_CE35C910_vertex_3, _CustomFunction_CE35C910_normal_4);
                description.VertexPosition = _CustomFunction_CE35C910_vertex_3;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float4 uv0;
                float4 uv3;
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
                float4 _Property_EC7746F0_Out_0 = _TrunkTilingOffset;
                float _Split_B742091E_R_1 = _Property_EC7746F0_Out_0[0];
                float _Split_B742091E_G_2 = _Property_EC7746F0_Out_0[1];
                float _Split_B742091E_B_3 = _Property_EC7746F0_Out_0[2];
                float _Split_B742091E_A_4 = _Property_EC7746F0_Out_0[3];
                float2 _Vector2_C5944BDD_Out_0 = float2(_Split_B742091E_R_1, _Split_B742091E_G_2);
                float2 _Vector2_A68E28C5_Out_0 = float2(_Split_B742091E_B_3, _Split_B742091E_A_4);
                float2 _TilingAndOffset_97CBEADA_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_C5944BDD_Out_0, _Vector2_A68E28C5_Out_0, _TilingAndOffset_97CBEADA_Out_3);
                float4 _SampleTexture2D_B919BA28_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_97CBEADA_Out_3);
                float _SampleTexture2D_B919BA28_R_4 = _SampleTexture2D_B919BA28_RGBA_0.r;
                float _SampleTexture2D_B919BA28_G_5 = _SampleTexture2D_B919BA28_RGBA_0.g;
                float _SampleTexture2D_B919BA28_B_6 = _SampleTexture2D_B919BA28_RGBA_0.b;
                float _SampleTexture2D_B919BA28_A_7 = _SampleTexture2D_B919BA28_RGBA_0.a;
                float4 _Property_7FC0454F_Out_0 = _TrunkBaseColor;
                float4 _Multiply_6F337D09_Out_2;
                Unity_Multiply_float(_SampleTexture2D_B919BA28_RGBA_0, _Property_7FC0454F_Out_0, _Multiply_6F337D09_Out_2);
                float _Property_91B33228_Out_0 = _BarkUseUV3;
                float4 _UV_D3D66B0E_Out_0 = IN.uv3;
                float4 _UV_62FB944B_Out_0 = IN.uv0;
                float4 _Branch_7E7DD05F_Out_3;
                Unity_Branch_float4(_Property_91B33228_Out_0, _UV_D3D66B0E_Out_0, _UV_62FB944B_Out_0, _Branch_7E7DD05F_Out_3);
                float4 _Property_67884C_Out_0 = _BarkTilingOffset;
                float _Split_6B4B02A_R_1 = _Property_67884C_Out_0[0];
                float _Split_6B4B02A_G_2 = _Property_67884C_Out_0[1];
                float _Split_6B4B02A_B_3 = _Property_67884C_Out_0[2];
                float _Split_6B4B02A_A_4 = _Property_67884C_Out_0[3];
                float2 _Vector2_A7F21F38_Out_0 = float2(_Split_6B4B02A_R_1, _Split_6B4B02A_G_2);
                float2 _Vector2_1DA22E74_Out_0 = float2(_Split_6B4B02A_B_3, _Split_6B4B02A_A_4);
                float2 _TilingAndOffset_3B5515F1_Out_3;
                Unity_TilingAndOffset_float((_Branch_7E7DD05F_Out_3.xy), _Vector2_A7F21F38_Out_0, _Vector2_1DA22E74_Out_0, _TilingAndOffset_3B5515F1_Out_3);
                float4 _SampleTexture2D_7E4BB55F_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_3B5515F1_Out_3);
                float _SampleTexture2D_7E4BB55F_R_4 = _SampleTexture2D_7E4BB55F_RGBA_0.r;
                float _SampleTexture2D_7E4BB55F_G_5 = _SampleTexture2D_7E4BB55F_RGBA_0.g;
                float _SampleTexture2D_7E4BB55F_B_6 = _SampleTexture2D_7E4BB55F_RGBA_0.b;
                float _SampleTexture2D_7E4BB55F_A_7 = _SampleTexture2D_7E4BB55F_RGBA_0.a;
                float4 _Property_400F851C_Out_0 = _BarkBaseColor;
                float4 _Multiply_22EAC4BF_Out_2;
                Unity_Multiply_float(_SampleTexture2D_7E4BB55F_RGBA_0, _Property_400F851C_Out_0, _Multiply_22EAC4BF_Out_2);
                float4 _Property_6F963EC1_Out_0 = _BarkBlendMaskTilingOffset;
                float _Split_7EFCE35C_R_1 = _Property_6F963EC1_Out_0[0];
                float _Split_7EFCE35C_G_2 = _Property_6F963EC1_Out_0[1];
                float _Split_7EFCE35C_B_3 = _Property_6F963EC1_Out_0[2];
                float _Split_7EFCE35C_A_4 = _Property_6F963EC1_Out_0[3];
                float2 _Vector2_3757C307_Out_0 = float2(_Split_7EFCE35C_R_1, _Split_7EFCE35C_G_2);
                float2 _Vector2_1FA6DD61_Out_0 = float2(_Split_7EFCE35C_B_3, _Split_7EFCE35C_A_4);
                float2 _TilingAndOffset_E00C37C5_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_3757C307_Out_0, _Vector2_1FA6DD61_Out_0, _TilingAndOffset_E00C37C5_Out_3);
                float4 _SampleTexture2D_BCB513F9_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_E00C37C5_Out_3);
                float _SampleTexture2D_BCB513F9_R_4 = _SampleTexture2D_BCB513F9_RGBA_0.r;
                float _SampleTexture2D_BCB513F9_G_5 = _SampleTexture2D_BCB513F9_RGBA_0.g;
                float _SampleTexture2D_BCB513F9_B_6 = _SampleTexture2D_BCB513F9_RGBA_0.b;
                float _SampleTexture2D_BCB513F9_A_7 = _SampleTexture2D_BCB513F9_RGBA_0.a;
                float4 _Lerp_FB04343D_Out_3;
                Unity_Lerp_float4(_Multiply_6F337D09_Out_2, _Multiply_22EAC4BF_Out_2, (_SampleTexture2D_BCB513F9_A_7.xxxx), _Lerp_FB04343D_Out_3);
                float4 _SampleTexture2D_AEF8D028_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkNormalMap, sampler_TrunkNormalMap, _TilingAndOffset_97CBEADA_Out_3);
                _SampleTexture2D_AEF8D028_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEF8D028_RGBA_0);
                float _SampleTexture2D_AEF8D028_R_4 = _SampleTexture2D_AEF8D028_RGBA_0.r;
                float _SampleTexture2D_AEF8D028_G_5 = _SampleTexture2D_AEF8D028_RGBA_0.g;
                float _SampleTexture2D_AEF8D028_B_6 = _SampleTexture2D_AEF8D028_RGBA_0.b;
                float _SampleTexture2D_AEF8D028_A_7 = _SampleTexture2D_AEF8D028_RGBA_0.a;
                float _Property_D03C5CAE_Out_0 = _TrunkNormalScale;
                float3 _NormalStrength_AA883695_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_AEF8D028_RGBA_0.xyz), _Property_D03C5CAE_Out_0, _NormalStrength_AA883695_Out_2);
                float4 _SampleTexture2D_D27E02B1_RGBA_0 = SAMPLE_TEXTURE2D(_BarkNormalMap, sampler_BarkNormalMap, _TilingAndOffset_3B5515F1_Out_3);
                _SampleTexture2D_D27E02B1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_D27E02B1_RGBA_0);
                float _SampleTexture2D_D27E02B1_R_4 = _SampleTexture2D_D27E02B1_RGBA_0.r;
                float _SampleTexture2D_D27E02B1_G_5 = _SampleTexture2D_D27E02B1_RGBA_0.g;
                float _SampleTexture2D_D27E02B1_B_6 = _SampleTexture2D_D27E02B1_RGBA_0.b;
                float _SampleTexture2D_D27E02B1_A_7 = _SampleTexture2D_D27E02B1_RGBA_0.a;
                float _Property_5257C6B7_Out_0 = _BarkNormalScale;
                float3 _NormalStrength_E4C4C9DF_Out_2;
                Unity_NormalStrength_float((_SampleTexture2D_D27E02B1_RGBA_0.xyz), _Property_5257C6B7_Out_0, _NormalStrength_E4C4C9DF_Out_2);
                float3 _Lerp_2035BBC1_Out_3;
                Unity_Lerp_float3(_NormalStrength_AA883695_Out_2, _NormalStrength_E4C4C9DF_Out_2, (_SampleTexture2D_BCB513F9_A_7.xxx), _Lerp_2035BBC1_Out_3);
                float4 _SampleTexture2D_709ACF8B_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkMaskMap, sampler_TrunkMaskMap, _TilingAndOffset_97CBEADA_Out_3);
                float _SampleTexture2D_709ACF8B_R_4 = _SampleTexture2D_709ACF8B_RGBA_0.r;
                float _SampleTexture2D_709ACF8B_G_5 = _SampleTexture2D_709ACF8B_RGBA_0.g;
                float _SampleTexture2D_709ACF8B_B_6 = _SampleTexture2D_709ACF8B_RGBA_0.b;
                float _SampleTexture2D_709ACF8B_A_7 = _SampleTexture2D_709ACF8B_RGBA_0.a;
                float _Property_88426352_Out_0 = _TrunkMetallic;
                float _Multiply_A9C7D801_Out_2;
                Unity_Multiply_float(_SampleTexture2D_709ACF8B_R_4, _Property_88426352_Out_0, _Multiply_A9C7D801_Out_2);
                float _Property_1255D061_Out_0 = _TrunkAORemapMin;
                float _Property_236DCA57_Out_0 = _TrunkAORemapMax;
                float2 _Vector2_BB8919_Out_0 = float2(_Property_1255D061_Out_0, _Property_236DCA57_Out_0);
                float _Remap_D81BE456_Out_3;
                Unity_Remap_float(_SampleTexture2D_709ACF8B_G_5, float2 (0, 1), _Vector2_BB8919_Out_0, _Remap_D81BE456_Out_3);
                float _Property_274EC17C_Out_0 = _TrunkSmoothnessRemapMin;
                float _Property_7A587A8B_Out_0 = _TrunkSmoothnessRemapMax;
                float2 _Vector2_5EC527FF_Out_0 = float2(_Property_274EC17C_Out_0, _Property_7A587A8B_Out_0);
                float _Remap_C92083DF_Out_3;
                Unity_Remap_float(_SampleTexture2D_709ACF8B_A_7, float2 (0, 1), _Vector2_5EC527FF_Out_0, _Remap_C92083DF_Out_3);
                float3 _Vector3_21EB658C_Out_0 = float3(_Multiply_A9C7D801_Out_2, _Remap_D81BE456_Out_3, _Remap_C92083DF_Out_3);
                float4 _SampleTexture2D_B8D305B2_RGBA_0 = SAMPLE_TEXTURE2D(_BarkMaskMap, sampler_BarkMaskMap, _TilingAndOffset_3B5515F1_Out_3);
                float _SampleTexture2D_B8D305B2_R_4 = _SampleTexture2D_B8D305B2_RGBA_0.r;
                float _SampleTexture2D_B8D305B2_G_5 = _SampleTexture2D_B8D305B2_RGBA_0.g;
                float _SampleTexture2D_B8D305B2_B_6 = _SampleTexture2D_B8D305B2_RGBA_0.b;
                float _SampleTexture2D_B8D305B2_A_7 = _SampleTexture2D_B8D305B2_RGBA_0.a;
                float _Property_ECE22503_Out_0 = _BarkMetallic;
                float _Multiply_4DD710E0_Out_2;
                Unity_Multiply_float(_SampleTexture2D_B8D305B2_R_4, _Property_ECE22503_Out_0, _Multiply_4DD710E0_Out_2);
                float _Property_E96C40EA_Out_0 = _BarkAORemapMin;
                float _Property_1B25B9C5_Out_0 = _BarkAORemapMax;
                float2 _Vector2_AF92BA2E_Out_0 = float2(_Property_E96C40EA_Out_0, _Property_1B25B9C5_Out_0);
                float _Remap_ABEE7F21_Out_3;
                Unity_Remap_float(_SampleTexture2D_B8D305B2_G_5, float2 (0, 1), _Vector2_AF92BA2E_Out_0, _Remap_ABEE7F21_Out_3);
                float _Property_8567B506_Out_0 = _BarkSmoothnessRemapMin;
                float _Property_73D88953_Out_0 = _BarkSmoothnessRemapMax;
                float2 _Vector2_CFA63B7C_Out_0 = float2(_Property_8567B506_Out_0, _Property_73D88953_Out_0);
                float _Remap_4448EBF2_Out_3;
                Unity_Remap_float(_SampleTexture2D_B8D305B2_A_7, float2 (0, 1), _Vector2_CFA63B7C_Out_0, _Remap_4448EBF2_Out_3);
                float3 _Vector3_D9E0914_Out_0 = float3(_Multiply_4DD710E0_Out_2, _Remap_ABEE7F21_Out_3, _Remap_4448EBF2_Out_3);
                float3 _Lerp_F1CF1610_Out_3;
                Unity_Lerp_float3(_Vector3_21EB658C_Out_0, _Vector3_D9E0914_Out_0, (_SampleTexture2D_BCB513F9_A_7.xxx), _Lerp_F1CF1610_Out_3);
                float _Split_D1329F45_R_1 = _Lerp_F1CF1610_Out_3[0];
                float _Split_D1329F45_G_2 = _Lerp_F1CF1610_Out_3[1];
                float _Split_D1329F45_B_3 = _Lerp_F1CF1610_Out_3[2];
                float _Split_D1329F45_A_4 = 0;
                surface.Albedo = (_Lerp_FB04343D_Out_3.xyz);
                surface.Normal = _Lerp_2035BBC1_Out_3;
                surface.Emission = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
                surface.Metallic = _Split_D1329F45_R_1;
                surface.Smoothness = _Split_D1329F45_B_3;
                surface.Occlusion = _Split_D1329F45_G_2;
                surface.Alpha = 1;
                surface.AlphaClipThreshold = 0.5;
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
                output.interp04.xyzw = input.texCoord3;
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
                output.texCoord3 = input.interp04.xyzw;
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
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
                output.uv0 =                         input.texCoord0;
                output.uv3 =                         input.texCoord3;
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
            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
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
            float4 _TrunkBaseColor;
            float4 _TrunkTilingOffset;
            float _TrunkNormalScale;
            float _TrunkMetallic;
            float _TrunkAORemapMin;
            float _TrunkAORemapMax;
            float _TrunkSmoothnessRemapMin;
            float _TrunkSmoothnessRemapMax;
            float4 _BarkBlendMaskTilingOffset;
            float4 _BarkBaseColor;
            float _BarkUseUV3;
            float4 _BarkTilingOffset;
            float _BarkNormalScale;
            float _BarkMetallic;
            float _BarkSmoothnessRemapMin;
            float _BarkSmoothnessRemapMax;
            float _BarkAORemapMin;
            float _BarkAORemapMax;
            float _Stiffness;
            float _InitialBend;
            float _Drag;
            float4 _NewNormal;
            CBUFFER_END
            TEXTURE2D(_TrunkBaseColorMap); SAMPLER(sampler_TrunkBaseColorMap); float4 _TrunkBaseColorMap_TexelSize;
            TEXTURE2D(_TrunkNormalMap); SAMPLER(sampler_TrunkNormalMap); float4 _TrunkNormalMap_TexelSize;
            TEXTURE2D(_TrunkMaskMap); SAMPLER(sampler_TrunkMaskMap); float4 _TrunkMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_BarkBaseColorMap); SAMPLER(sampler_BarkBaseColorMap); float4 _BarkBaseColorMap_TexelSize;
            TEXTURE2D(_BarkNormalMap); SAMPLER(sampler_BarkNormalMap); float4 _BarkNormalMap_TexelSize;
            TEXTURE2D(_BarkMaskMap); SAMPLER(sampler_BarkMaskMap); float4 _BarkMaskMap_TexelSize;
        
            // Graph Functions
            
            // 02092042f8fbe23da7886005ee29c06a
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
            {
            };
            
            void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
            // cffff589f98579275da61b43e2de268d
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
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
                Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_6AFECCFE;
                float3 _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1;
                SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_6AFECCFE, _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1);
                float3 _CustomFunction_CE35C910_vertex_3;
                float3 _CustomFunction_CE35C910_normal_4;
                CalculateWind_float(_NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_CE35C910_vertex_3, _CustomFunction_CE35C910_normal_4);
                description.VertexPosition = _CustomFunction_CE35C910_vertex_3;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
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
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
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
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
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
                Varyings output = (Varyings)0;
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
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
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
            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
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
            float4 _TrunkBaseColor;
            float4 _TrunkTilingOffset;
            float _TrunkNormalScale;
            float _TrunkMetallic;
            float _TrunkAORemapMin;
            float _TrunkAORemapMax;
            float _TrunkSmoothnessRemapMin;
            float _TrunkSmoothnessRemapMax;
            float4 _BarkBlendMaskTilingOffset;
            float4 _BarkBaseColor;
            float _BarkUseUV3;
            float4 _BarkTilingOffset;
            float _BarkNormalScale;
            float _BarkMetallic;
            float _BarkSmoothnessRemapMin;
            float _BarkSmoothnessRemapMax;
            float _BarkAORemapMin;
            float _BarkAORemapMax;
            float _Stiffness;
            float _InitialBend;
            float _Drag;
            float4 _NewNormal;
            CBUFFER_END
            TEXTURE2D(_TrunkBaseColorMap); SAMPLER(sampler_TrunkBaseColorMap); float4 _TrunkBaseColorMap_TexelSize;
            TEXTURE2D(_TrunkNormalMap); SAMPLER(sampler_TrunkNormalMap); float4 _TrunkNormalMap_TexelSize;
            TEXTURE2D(_TrunkMaskMap); SAMPLER(sampler_TrunkMaskMap); float4 _TrunkMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_BarkBaseColorMap); SAMPLER(sampler_BarkBaseColorMap); float4 _BarkBaseColorMap_TexelSize;
            TEXTURE2D(_BarkNormalMap); SAMPLER(sampler_BarkNormalMap); float4 _BarkNormalMap_TexelSize;
            TEXTURE2D(_BarkMaskMap); SAMPLER(sampler_BarkMaskMap); float4 _BarkMaskMap_TexelSize;
        
            // Graph Functions
            
            // 02092042f8fbe23da7886005ee29c06a
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
            {
            };
            
            void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
            // cffff589f98579275da61b43e2de268d
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
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
                Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_6AFECCFE;
                float3 _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1;
                SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_6AFECCFE, _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1);
                float3 _CustomFunction_CE35C910_vertex_3;
                float3 _CustomFunction_CE35C910_normal_4;
                CalculateWind_float(_NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_CE35C910_vertex_3, _CustomFunction_CE35C910_normal_4);
                description.VertexPosition = _CustomFunction_CE35C910_vertex_3;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
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
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
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
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
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
                Varyings output = (Varyings)0;
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
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);
            
                output.ObjectSpaceNormal =           input.normalOS;
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
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
            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
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
            float4 _TrunkBaseColor;
            float4 _TrunkTilingOffset;
            float _TrunkNormalScale;
            float _TrunkMetallic;
            float _TrunkAORemapMin;
            float _TrunkAORemapMax;
            float _TrunkSmoothnessRemapMin;
            float _TrunkSmoothnessRemapMax;
            float4 _BarkBlendMaskTilingOffset;
            float4 _BarkBaseColor;
            float _BarkUseUV3;
            float4 _BarkTilingOffset;
            float _BarkNormalScale;
            float _BarkMetallic;
            float _BarkSmoothnessRemapMin;
            float _BarkSmoothnessRemapMax;
            float _BarkAORemapMin;
            float _BarkAORemapMax;
            float _Stiffness;
            float _InitialBend;
            float _Drag;
            float4 _NewNormal;
            CBUFFER_END
            TEXTURE2D(_TrunkBaseColorMap); SAMPLER(sampler_TrunkBaseColorMap); float4 _TrunkBaseColorMap_TexelSize;
            TEXTURE2D(_TrunkNormalMap); SAMPLER(sampler_TrunkNormalMap); float4 _TrunkNormalMap_TexelSize;
            TEXTURE2D(_TrunkMaskMap); SAMPLER(sampler_TrunkMaskMap); float4 _TrunkMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_BarkBaseColorMap); SAMPLER(sampler_BarkBaseColorMap); float4 _BarkBaseColorMap_TexelSize;
            TEXTURE2D(_BarkNormalMap); SAMPLER(sampler_BarkNormalMap); float4 _BarkNormalMap_TexelSize;
            TEXTURE2D(_BarkMaskMap); SAMPLER(sampler_BarkMaskMap); float4 _BarkMaskMap_TexelSize;
            SAMPLER(_SampleTexture2D_B919BA28_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_7E4BB55F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_BCB513F9_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // 02092042f8fbe23da7886005ee29c06a
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
            {
            };
            
            void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
            // cffff589f98579275da61b43e2de268d
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
            
            void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
            {
                Out = UV * Tiling + Offset;
            }
            
            void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
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
                Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_6AFECCFE;
                float3 _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1;
                SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_6AFECCFE, _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1);
                float3 _CustomFunction_CE35C910_vertex_3;
                float3 _CustomFunction_CE35C910_normal_4;
                CalculateWind_float(_NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_CE35C910_vertex_3, _CustomFunction_CE35C910_normal_4);
                description.VertexPosition = _CustomFunction_CE35C910_vertex_3;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float4 uv0;
                float4 uv3;
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
                float4 _Property_EC7746F0_Out_0 = _TrunkTilingOffset;
                float _Split_B742091E_R_1 = _Property_EC7746F0_Out_0[0];
                float _Split_B742091E_G_2 = _Property_EC7746F0_Out_0[1];
                float _Split_B742091E_B_3 = _Property_EC7746F0_Out_0[2];
                float _Split_B742091E_A_4 = _Property_EC7746F0_Out_0[3];
                float2 _Vector2_C5944BDD_Out_0 = float2(_Split_B742091E_R_1, _Split_B742091E_G_2);
                float2 _Vector2_A68E28C5_Out_0 = float2(_Split_B742091E_B_3, _Split_B742091E_A_4);
                float2 _TilingAndOffset_97CBEADA_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_C5944BDD_Out_0, _Vector2_A68E28C5_Out_0, _TilingAndOffset_97CBEADA_Out_3);
                float4 _SampleTexture2D_B919BA28_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_97CBEADA_Out_3);
                float _SampleTexture2D_B919BA28_R_4 = _SampleTexture2D_B919BA28_RGBA_0.r;
                float _SampleTexture2D_B919BA28_G_5 = _SampleTexture2D_B919BA28_RGBA_0.g;
                float _SampleTexture2D_B919BA28_B_6 = _SampleTexture2D_B919BA28_RGBA_0.b;
                float _SampleTexture2D_B919BA28_A_7 = _SampleTexture2D_B919BA28_RGBA_0.a;
                float4 _Property_7FC0454F_Out_0 = _TrunkBaseColor;
                float4 _Multiply_6F337D09_Out_2;
                Unity_Multiply_float(_SampleTexture2D_B919BA28_RGBA_0, _Property_7FC0454F_Out_0, _Multiply_6F337D09_Out_2);
                float _Property_91B33228_Out_0 = _BarkUseUV3;
                float4 _UV_D3D66B0E_Out_0 = IN.uv3;
                float4 _UV_62FB944B_Out_0 = IN.uv0;
                float4 _Branch_7E7DD05F_Out_3;
                Unity_Branch_float4(_Property_91B33228_Out_0, _UV_D3D66B0E_Out_0, _UV_62FB944B_Out_0, _Branch_7E7DD05F_Out_3);
                float4 _Property_67884C_Out_0 = _BarkTilingOffset;
                float _Split_6B4B02A_R_1 = _Property_67884C_Out_0[0];
                float _Split_6B4B02A_G_2 = _Property_67884C_Out_0[1];
                float _Split_6B4B02A_B_3 = _Property_67884C_Out_0[2];
                float _Split_6B4B02A_A_4 = _Property_67884C_Out_0[3];
                float2 _Vector2_A7F21F38_Out_0 = float2(_Split_6B4B02A_R_1, _Split_6B4B02A_G_2);
                float2 _Vector2_1DA22E74_Out_0 = float2(_Split_6B4B02A_B_3, _Split_6B4B02A_A_4);
                float2 _TilingAndOffset_3B5515F1_Out_3;
                Unity_TilingAndOffset_float((_Branch_7E7DD05F_Out_3.xy), _Vector2_A7F21F38_Out_0, _Vector2_1DA22E74_Out_0, _TilingAndOffset_3B5515F1_Out_3);
                float4 _SampleTexture2D_7E4BB55F_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_3B5515F1_Out_3);
                float _SampleTexture2D_7E4BB55F_R_4 = _SampleTexture2D_7E4BB55F_RGBA_0.r;
                float _SampleTexture2D_7E4BB55F_G_5 = _SampleTexture2D_7E4BB55F_RGBA_0.g;
                float _SampleTexture2D_7E4BB55F_B_6 = _SampleTexture2D_7E4BB55F_RGBA_0.b;
                float _SampleTexture2D_7E4BB55F_A_7 = _SampleTexture2D_7E4BB55F_RGBA_0.a;
                float4 _Property_400F851C_Out_0 = _BarkBaseColor;
                float4 _Multiply_22EAC4BF_Out_2;
                Unity_Multiply_float(_SampleTexture2D_7E4BB55F_RGBA_0, _Property_400F851C_Out_0, _Multiply_22EAC4BF_Out_2);
                float4 _Property_6F963EC1_Out_0 = _BarkBlendMaskTilingOffset;
                float _Split_7EFCE35C_R_1 = _Property_6F963EC1_Out_0[0];
                float _Split_7EFCE35C_G_2 = _Property_6F963EC1_Out_0[1];
                float _Split_7EFCE35C_B_3 = _Property_6F963EC1_Out_0[2];
                float _Split_7EFCE35C_A_4 = _Property_6F963EC1_Out_0[3];
                float2 _Vector2_3757C307_Out_0 = float2(_Split_7EFCE35C_R_1, _Split_7EFCE35C_G_2);
                float2 _Vector2_1FA6DD61_Out_0 = float2(_Split_7EFCE35C_B_3, _Split_7EFCE35C_A_4);
                float2 _TilingAndOffset_E00C37C5_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_3757C307_Out_0, _Vector2_1FA6DD61_Out_0, _TilingAndOffset_E00C37C5_Out_3);
                float4 _SampleTexture2D_BCB513F9_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_E00C37C5_Out_3);
                float _SampleTexture2D_BCB513F9_R_4 = _SampleTexture2D_BCB513F9_RGBA_0.r;
                float _SampleTexture2D_BCB513F9_G_5 = _SampleTexture2D_BCB513F9_RGBA_0.g;
                float _SampleTexture2D_BCB513F9_B_6 = _SampleTexture2D_BCB513F9_RGBA_0.b;
                float _SampleTexture2D_BCB513F9_A_7 = _SampleTexture2D_BCB513F9_RGBA_0.a;
                float4 _Lerp_FB04343D_Out_3;
                Unity_Lerp_float4(_Multiply_6F337D09_Out_2, _Multiply_22EAC4BF_Out_2, (_SampleTexture2D_BCB513F9_A_7.xxxx), _Lerp_FB04343D_Out_3);
                surface.Albedo = (_Lerp_FB04343D_Out_3.xyz);
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
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                float4 uv2 : TEXCOORD2;
                float4 uv3 : TEXCOORD3;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0;
                float4 texCoord3;
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
                float4 interp00 : TEXCOORD0;
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
                output.interp00.xyzw = input.texCoord0;
                output.interp01.xyzw = input.texCoord3;
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
                output.texCoord0 = input.interp00.xyzw;
                output.texCoord3 = input.interp01.xyzw;
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
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
                output.uv0 =                         input.texCoord0;
                output.uv3 =                         input.texCoord3;
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
            // GraphKeywords: <None>
            
            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
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
            float4 _TrunkBaseColor;
            float4 _TrunkTilingOffset;
            float _TrunkNormalScale;
            float _TrunkMetallic;
            float _TrunkAORemapMin;
            float _TrunkAORemapMax;
            float _TrunkSmoothnessRemapMin;
            float _TrunkSmoothnessRemapMax;
            float4 _BarkBlendMaskTilingOffset;
            float4 _BarkBaseColor;
            float _BarkUseUV3;
            float4 _BarkTilingOffset;
            float _BarkNormalScale;
            float _BarkMetallic;
            float _BarkSmoothnessRemapMin;
            float _BarkSmoothnessRemapMax;
            float _BarkAORemapMin;
            float _BarkAORemapMax;
            float _Stiffness;
            float _InitialBend;
            float _Drag;
            float4 _NewNormal;
            CBUFFER_END
            TEXTURE2D(_TrunkBaseColorMap); SAMPLER(sampler_TrunkBaseColorMap); float4 _TrunkBaseColorMap_TexelSize;
            TEXTURE2D(_TrunkNormalMap); SAMPLER(sampler_TrunkNormalMap); float4 _TrunkNormalMap_TexelSize;
            TEXTURE2D(_TrunkMaskMap); SAMPLER(sampler_TrunkMaskMap); float4 _TrunkMaskMap_TexelSize;
            TEXTURE2D(_LayerMask); SAMPLER(sampler_LayerMask); float4 _LayerMask_TexelSize;
            TEXTURE2D(_BarkBaseColorMap); SAMPLER(sampler_BarkBaseColorMap); float4 _BarkBaseColorMap_TexelSize;
            TEXTURE2D(_BarkNormalMap); SAMPLER(sampler_BarkNormalMap); float4 _BarkNormalMap_TexelSize;
            TEXTURE2D(_BarkMaskMap); SAMPLER(sampler_BarkMaskMap); float4 _BarkMaskMap_TexelSize;
            SAMPLER(_SampleTexture2D_B919BA28_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_7E4BB55F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_BCB513F9_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            // 02092042f8fbe23da7886005ee29c06a
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"
            
            void AddPragma_float(float3 A, out float3 Out)
            {
                #pragma instancing_options renderinglayer procedural:setupVSPro
                Out = A;
            }
            
            struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
            {
            };
            
            void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
            {
                float3 _Property_AF5E8C93_Out_0 = Vector3_314C8600;
                float3 _CustomFunction_E07FEE57_Out_1;
                InjectSetup_float(_Property_AF5E8C93_Out_0, _CustomFunction_E07FEE57_Out_1);
                float3 _CustomFunction_18EFD858_Out_1;
                AddPragma_float(_CustomFunction_E07FEE57_Out_1, _CustomFunction_18EFD858_Out_1);
                ObjectSpacePosition_1 = _CustomFunction_18EFD858_Out_1;
            }
            
            // cffff589f98579275da61b43e2de268d
            #include "Assets/NatureManufacture Assets/Foliage Shaders/NMWindNoShiver.hlsl"
            
            void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
            {
                Out = UV * Tiling + Offset;
            }
            
            void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
            {
                Out = lerp(A, B, T);
            }
        
            // Graph Vertex
            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
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
                Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_6AFECCFE;
                float3 _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1;
                SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_6AFECCFE, _NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1);
                float3 _CustomFunction_CE35C910_vertex_3;
                float3 _CustomFunction_CE35C910_normal_4;
                CalculateWind_float(_NMFoliageVSProIndirect_6AFECCFE_ObjectSpacePosition_1, IN.ObjectSpaceNormal, IN.TimeParameters.x, _CustomFunction_CE35C910_vertex_3, _CustomFunction_CE35C910_normal_4);
                description.VertexPosition = _CustomFunction_CE35C910_vertex_3;
                description.VertexNormal = IN.ObjectSpaceNormal;
                description.VertexTangent = IN.ObjectSpaceTangent;
                return description;
            }
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                float4 uv0;
                float4 uv3;
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
                float4 _Property_EC7746F0_Out_0 = _TrunkTilingOffset;
                float _Split_B742091E_R_1 = _Property_EC7746F0_Out_0[0];
                float _Split_B742091E_G_2 = _Property_EC7746F0_Out_0[1];
                float _Split_B742091E_B_3 = _Property_EC7746F0_Out_0[2];
                float _Split_B742091E_A_4 = _Property_EC7746F0_Out_0[3];
                float2 _Vector2_C5944BDD_Out_0 = float2(_Split_B742091E_R_1, _Split_B742091E_G_2);
                float2 _Vector2_A68E28C5_Out_0 = float2(_Split_B742091E_B_3, _Split_B742091E_A_4);
                float2 _TilingAndOffset_97CBEADA_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_C5944BDD_Out_0, _Vector2_A68E28C5_Out_0, _TilingAndOffset_97CBEADA_Out_3);
                float4 _SampleTexture2D_B919BA28_RGBA_0 = SAMPLE_TEXTURE2D(_TrunkBaseColorMap, sampler_TrunkBaseColorMap, _TilingAndOffset_97CBEADA_Out_3);
                float _SampleTexture2D_B919BA28_R_4 = _SampleTexture2D_B919BA28_RGBA_0.r;
                float _SampleTexture2D_B919BA28_G_5 = _SampleTexture2D_B919BA28_RGBA_0.g;
                float _SampleTexture2D_B919BA28_B_6 = _SampleTexture2D_B919BA28_RGBA_0.b;
                float _SampleTexture2D_B919BA28_A_7 = _SampleTexture2D_B919BA28_RGBA_0.a;
                float4 _Property_7FC0454F_Out_0 = _TrunkBaseColor;
                float4 _Multiply_6F337D09_Out_2;
                Unity_Multiply_float(_SampleTexture2D_B919BA28_RGBA_0, _Property_7FC0454F_Out_0, _Multiply_6F337D09_Out_2);
                float _Property_91B33228_Out_0 = _BarkUseUV3;
                float4 _UV_D3D66B0E_Out_0 = IN.uv3;
                float4 _UV_62FB944B_Out_0 = IN.uv0;
                float4 _Branch_7E7DD05F_Out_3;
                Unity_Branch_float4(_Property_91B33228_Out_0, _UV_D3D66B0E_Out_0, _UV_62FB944B_Out_0, _Branch_7E7DD05F_Out_3);
                float4 _Property_67884C_Out_0 = _BarkTilingOffset;
                float _Split_6B4B02A_R_1 = _Property_67884C_Out_0[0];
                float _Split_6B4B02A_G_2 = _Property_67884C_Out_0[1];
                float _Split_6B4B02A_B_3 = _Property_67884C_Out_0[2];
                float _Split_6B4B02A_A_4 = _Property_67884C_Out_0[3];
                float2 _Vector2_A7F21F38_Out_0 = float2(_Split_6B4B02A_R_1, _Split_6B4B02A_G_2);
                float2 _Vector2_1DA22E74_Out_0 = float2(_Split_6B4B02A_B_3, _Split_6B4B02A_A_4);
                float2 _TilingAndOffset_3B5515F1_Out_3;
                Unity_TilingAndOffset_float((_Branch_7E7DD05F_Out_3.xy), _Vector2_A7F21F38_Out_0, _Vector2_1DA22E74_Out_0, _TilingAndOffset_3B5515F1_Out_3);
                float4 _SampleTexture2D_7E4BB55F_RGBA_0 = SAMPLE_TEXTURE2D(_BarkBaseColorMap, sampler_BarkBaseColorMap, _TilingAndOffset_3B5515F1_Out_3);
                float _SampleTexture2D_7E4BB55F_R_4 = _SampleTexture2D_7E4BB55F_RGBA_0.r;
                float _SampleTexture2D_7E4BB55F_G_5 = _SampleTexture2D_7E4BB55F_RGBA_0.g;
                float _SampleTexture2D_7E4BB55F_B_6 = _SampleTexture2D_7E4BB55F_RGBA_0.b;
                float _SampleTexture2D_7E4BB55F_A_7 = _SampleTexture2D_7E4BB55F_RGBA_0.a;
                float4 _Property_400F851C_Out_0 = _BarkBaseColor;
                float4 _Multiply_22EAC4BF_Out_2;
                Unity_Multiply_float(_SampleTexture2D_7E4BB55F_RGBA_0, _Property_400F851C_Out_0, _Multiply_22EAC4BF_Out_2);
                float4 _Property_6F963EC1_Out_0 = _BarkBlendMaskTilingOffset;
                float _Split_7EFCE35C_R_1 = _Property_6F963EC1_Out_0[0];
                float _Split_7EFCE35C_G_2 = _Property_6F963EC1_Out_0[1];
                float _Split_7EFCE35C_B_3 = _Property_6F963EC1_Out_0[2];
                float _Split_7EFCE35C_A_4 = _Property_6F963EC1_Out_0[3];
                float2 _Vector2_3757C307_Out_0 = float2(_Split_7EFCE35C_R_1, _Split_7EFCE35C_G_2);
                float2 _Vector2_1FA6DD61_Out_0 = float2(_Split_7EFCE35C_B_3, _Split_7EFCE35C_A_4);
                float2 _TilingAndOffset_E00C37C5_Out_3;
                Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_3757C307_Out_0, _Vector2_1FA6DD61_Out_0, _TilingAndOffset_E00C37C5_Out_3);
                float4 _SampleTexture2D_BCB513F9_RGBA_0 = SAMPLE_TEXTURE2D(_LayerMask, sampler_LayerMask, _TilingAndOffset_E00C37C5_Out_3);
                float _SampleTexture2D_BCB513F9_R_4 = _SampleTexture2D_BCB513F9_RGBA_0.r;
                float _SampleTexture2D_BCB513F9_G_5 = _SampleTexture2D_BCB513F9_RGBA_0.g;
                float _SampleTexture2D_BCB513F9_B_6 = _SampleTexture2D_BCB513F9_RGBA_0.b;
                float _SampleTexture2D_BCB513F9_A_7 = _SampleTexture2D_BCB513F9_RGBA_0.a;
                float4 _Lerp_FB04343D_Out_3;
                Unity_Lerp_float4(_Multiply_6F337D09_Out_2, _Multiply_22EAC4BF_Out_2, (_SampleTexture2D_BCB513F9_A_7.xxxx), _Lerp_FB04343D_Out_3);
                surface.Albedo = (_Lerp_FB04343D_Out_3.xyz);
                surface.Alpha = 1;
                surface.AlphaClipThreshold = 0.5;
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
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0;
                float4 texCoord3;
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
                float4 interp00 : TEXCOORD0;
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
                output.interp00.xyzw = input.texCoord0;
                output.interp01.xyzw = input.texCoord3;
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
                output.texCoord0 = input.interp00.xyzw;
                output.texCoord3 = input.interp01.xyzw;
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
                output.ObjectSpaceTangent =          input.tangentOS;
                output.ObjectSpacePosition =         input.positionOS;
                output.TimeParameters =              _TimeParameters.xyz;
            
                return output;
            }
            
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
                output.uv0 =                         input.texCoord0;
                output.uv3 =                         input.texCoord3;
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
