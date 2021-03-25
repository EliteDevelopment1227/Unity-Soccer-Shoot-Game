Shader "Marc Sureda/Mobile/StylizedWaterMobile" {
	Properties {
		_Color0 ("Color0", Vector) = (0.1877163,0.9117647,0.6421192,1)
		_Gradient1 ("Gradient1", Float) = 1
		_Color1 ("Color1", Vector) = (0.1877163,0.6421192,0.9117647,1)
		_Gradient2 ("Gradient2", Float) = 2
		_Color2 ("Color2", Vector) = (0.1712803,0.2384142,0.4852941,1)
		_FresnelColor ("FresnelColor", Vector) = (0.7205882,0.907505,1,1)
		_FresnelExp ("FresnelExp", Float) = 5
		_MainFoamIntensity ("MainFoamIntensity", Float) = 1
		_MainFoamScale ("MainFoamScale", Float) = 1
		_MainFoamOpacity ("MainFoamOpacity", Range(0, 1)) = 1
		_MainSpeed ("MainSpeed", Float) = 0.05
		_SecondaryFoamIntensity ("SecondaryFoamIntensity", Float) = 1
		_SecondaryFoamScale ("SecondaryFoamScale", Float) = 1
		_SecondaryFoamOpacity ("SecondaryFoamOpacity", Range(0, 1)) = 1
		_SecondarySpeed ("MainSpeed", Float) = -0.05
		_WaterTexture ("WaterTexture", 2D) = "white" {}
	}
	SubShader {
		Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ZWrite Off
			GpuProgramID 25525
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    SV_Target0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute highp vec2 in_TEXCOORD0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _WaterTexture;
					varying highp vec2 vs_TEXCOORD0;
					varying highp float vs_TEXCOORD4;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD2;
					varying highp vec4 vs_TEXCOORD3;
					#define SV_Target0 gl_FragData[0]
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					lowp float u_xlat10_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture2D(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_4 = texture2D(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat10_4 * u_xlat10_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat10_1 = texture2D(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat10_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_FogParams;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat2.xyz;
					    u_xlat6 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat6;
					    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat6;
					    vs_TEXCOORD3.z = (-u_xlat6);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.w = u_xlat0.w;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_FogColor;
					uniform 	float _Gradient2;
					uniform 	vec4 _Color1;
					uniform 	vec4 _Color2;
					uniform 	float _MainFoamIntensity;
					uniform 	float _MainFoamScale;
					uniform 	vec4 _Color0;
					uniform 	float _Gradient1;
					uniform 	vec4 _WaterTexture_ST;
					uniform 	float _MainFoamOpacity;
					uniform 	float _SecondaryFoamIntensity;
					uniform 	float _SecondaryFoamScale;
					uniform 	float _SecondaryFoamOpacity;
					uniform 	vec4 _FresnelColor;
					uniform 	float _FresnelExp;
					uniform 	float _MainSpeed;
					uniform 	float _SecondarySpeed;
					UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
					UNITY_LOCATION(1) uniform mediump sampler2D _WaterTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump float u_xlat16_1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					mediump float u_xlat16_4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelExp;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat3.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
					    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat3.x = u_xlat3.x + (-_ProjectionParams.y);
					    u_xlat3.y = vs_TEXCOORD3.z + (-_ProjectionParams.y);
					    u_xlat3.xy = max(u_xlat3.xy, vec2(0.0, 0.0));
					    u_xlat3.x = (-u_xlat3.y) + u_xlat3.x;
					    u_xlat6 = u_xlat3.x / _Gradient1;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = _Color1.xyz + (-_Color0.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _Color0.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _Color2.xyz;
					    u_xlat6 = u_xlat3.x / _Gradient2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
					#else
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _FresnelColor.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xy = _Time.yy * vec2(_MainSpeed, _SecondarySpeed);
					    u_xlat1.xz = vs_TEXCOORD0.xy * vec2(vec2(_MainFoamScale, _MainFoamScale)) + u_xlat1.xx;
					    u_xlat4.xz = vs_TEXCOORD0.xy * vec2(vec2(_SecondaryFoamScale, _SecondaryFoamScale)) + u_xlat1.yy;
					    u_xlat4.xz = u_xlat4.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_4 = texture(_WaterTexture, u_xlat4.xz).x;
					    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
					    u_xlat4.x = u_xlat16_4 * _SecondaryFoamOpacity;
					    u_xlat1.xz = u_xlat1.xz * _WaterTexture_ST.xy + _WaterTexture_ST.zw;
					    u_xlat16_1 = texture(_WaterTexture, u_xlat1.xz).x;
					    u_xlat1.x = u_xlat16_1 * _MainFoamIntensity;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat1.x = _MainFoamIntensity * 0.200000003 + u_xlat1.x;
					    u_xlat1.x = u_xlat3.x / u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x / _SecondaryFoamIntensity;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.x = u_xlat3.x * (-u_xlat4.x) + u_xlat4.x;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat3.x = _MainFoamOpacity * u_xlat1.x + u_xlat3.x;
					    u_xlat0.xyz = u_xlat0.xzw + u_xlat3.xxx;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" }
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"!!!!GLES3"
				}
			}
		}
	}
	Fallback "Diffuse"
}