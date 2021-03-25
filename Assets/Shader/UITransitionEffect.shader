Shader "UI/TransitionEffect" {
	Properties {
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Scale ("Scale", Range(0.02, 2)) = 1
		_Color ("Tint", Vector) = (1,1,1,1)
		_BgColor ("Background", Vector) = (1,1,1,1)
		_VignetteColor ("VignetteColor", Vector) = (0,0,0,1)
		_VignettePos ("VignettePos", Range(0, 1)) = 0.1
		_VignetteSize ("VignetteSize", Range(0, 1)) = 0.1
		_Transition ("Transition", Range(0, 1)) = 0.5
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
	}
	SubShader {
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "Default"
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask 0 -1
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 0
				WriteMask 0
				Comp Disabled
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 23842
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bool u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_3 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					    u_xlatb1 = u_xlat16_3<0.0;
					    if(((int(u_xlatb1) * -1))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bool u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_3 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					    u_xlatb1 = u_xlat16_3<0.0;
					    if(((int(u_xlatb1) * -1))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bool u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_3 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					    u_xlatb1 = u_xlat16_3<0.0;
					    if(((int(u_xlatb1) * -1))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bool u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_3 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb1 = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bool u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_3 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb1 = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bool u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_3 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb1 = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat3 = u_xlat3 / _VignetteSize;
					    u_xlat6.x = float(1.0) / _Scale;
					    u_xlat6.x = u_xlat6.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat6.xy = u_xlat6.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat6.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat6.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat6.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat6.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat16_3 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    u_xlatb1.x = u_xlat16_3<0.0;
					    if(((int(u_xlatb1.x) * -1))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat16_3 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    u_xlatb1.x = u_xlat16_3<0.0;
					    if(((int(u_xlatb1.x) * -1))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					attribute highp vec4 in_POSITION0;
					attribute highp vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					uniform lowp sampler2D _MainTex;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat10_1 = texture2D(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat16_3 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					    u_xlatb1.x = u_xlat16_3<0.0;
					    if(((int(u_xlatb1.x) * -1))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat16_3 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1.x = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb1.x = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb1.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat16_3 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1.x = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb1.x = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb1.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	mediump vec4 _Color;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0 = in_COLOR0 * _Color;
					    vs_COLOR0 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1 = in_POSITION0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	mediump vec4 _BgColor;
					uniform 	mediump vec4 _VignetteColor;
					uniform 	float _Scale;
					uniform 	float _VignettePos;
					uniform 	float _VignetteSize;
					uniform 	float _Transition;
					uniform 	mediump vec4 _TextureSampleAdd;
					uniform 	vec4 _ClipRect;
					UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					bool u_xlatb0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					vec2 u_xlat8;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + vec2(0.5, 0.5);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y + u_xlat0.x;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat4 = u_xlat0.x + (-_VignettePos);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_VignettePos<u_xlat0.x);
					#else
					    u_xlatb0 = _VignettePos<u_xlat0.x;
					#endif
					    u_xlat4 = u_xlat4 / _VignetteSize;
					    u_xlat8.x = float(1.0) / _Scale;
					    u_xlat8.x = u_xlat8.x + -1.0;
					    u_xlat1.xy = vs_TEXCOORD0.xy / vec2(_Scale);
					    u_xlat8.xy = u_xlat8.xx * vec2(-0.5, -0.5) + u_xlat1.xy;
					    u_xlat16_1 = texture(_MainTex, u_xlat8.xy);
					    u_xlat16_1 = u_xlat16_1 + _TextureSampleAdd;
					    u_xlat8.x = u_xlat16_1.w * _Transition;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_BgColor.xyz);
					    u_xlat2.xyz = u_xlat8.xxx * u_xlat16_1.xyz + _BgColor.xyz;
					    u_xlat8.x = (-_Transition) + 1.0;
					    u_xlat2.w = (-u_xlat16_1.w) * u_xlat8.x + 1.0;
					    u_xlat1 = (-u_xlat2) + _VignetteColor;
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat2;
					    u_xlat16_0 = (bool(u_xlatb0)) ? u_xlat1 : u_xlat2;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
					    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat16_3 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
					    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1.x = !!(u_xlat16_3<0.0);
					#else
					    u_xlatb1.x = u_xlat16_3<0.0;
					#endif
					    if(((int(u_xlatb1.x) * int(0xffffffffu)))!=0){discard;}
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!!!GLES3"
				}
			}
		}
	}
}