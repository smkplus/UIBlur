Shader "Hidden/GrayScale"
{ 
Properties
{
_MainTex ("Base (RGB)", 2D) = "white" {}
_EffectAmount ("Effect Amount", Range (0,1)) = 1.0
}

SubShader
{
//ZWrite Off

Pass
{

CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"

struct appdata_t
{
float4 vertex   : POSITION;
float2 texcoord : TEXCOORD0;
};

struct v2f
{
half2 texcoord  : TEXCOORD0;
float4 vertex   : SV_POSITION;
};

uniform float _EffectAmount;
sampler2D _MainTex;

v2f vert(appdata_t IN)
{
v2f OUT;
OUT.vertex = UnityObjectToClipPos(IN.vertex);
OUT.texcoord = IN.texcoord;
return OUT;
}

float4 frag (v2f i) : COLOR
{
fixed4 c = tex2D(_MainTex, i.texcoord);
c.rgb = lerp(c.rgb, dot(c.rgb, fixed3(0.3, 0.59, 0.11)), _EffectAmount);
c.a = c.a;
return float4(c.rgb,c.a);
}
ENDCG
}
}
Fallback "Sprites/Default"

}