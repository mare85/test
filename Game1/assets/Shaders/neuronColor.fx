cbuffer cbChangesPerFrame : register(b0)
{
	matrix world_;
	matrix view_;
	matrix projection_;
};

struct VS_Input
{
	float4 pos : POSITION;
};
struct PS_Input
{
	float4 pos : SV_POSITION;
	float dist : TEXCOORD0;
};


PS_Input vs_main(VS_Input vertex)
{
	PS_Input vsOut = (PS_Input)0;
	matrix wv = mul( view_, world_ );
	//matrix vp = mul(projection_, view_);
	
	//matrix wvp = mul(vp, world_ );
	matrix wvp = mul( projection_, wv );
	vsOut.pos = mul(wvp, vertex.pos);
	vsOut.dist = length( ( mul ( wv, vertex.pos ) ).xyz );
	return vsOut;
}
float4 ps_main(PS_Input frag ) : SV_TARGET
{
	float col = max( .025, 1.0 - frag.dist * .02 );
	return float4(col, col, col, 1.0); 
}