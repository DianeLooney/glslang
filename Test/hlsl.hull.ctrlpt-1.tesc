// *** 
// per-control-point invocation of PCF from entry point return value
// ***

struct hs_in_t
{
    float3 val : TEXCOORD0;
};

struct hs_pcf_t
{
    float tfactor[3] : SV_TessFactor;
    float flInFactor : SV_InsideTessFactor;
}; 

struct hs_out_t
{
    float3 val : TEXCOORD0; 
};

[ domain ("tri") ]
[ partitioning ("fractional_odd") ]
[ outputtopology ("triangle_cw") ]
[ outputcontrolpoints (3) ]
[ patchconstantfunc ( "PCF" ) ]
hs_out_t main (InputPatch <hs_in_t, 3> i , uint cpid : SV_OutputControlPointID)
{
    hs_out_t o;
    o.val = cpid;
    return o;
}

hs_pcf_t PCF( const OutputPatch <hs_out_t, 3> pcf_out)
{
    hs_pcf_t o;

    o.tfactor[0] = pcf_out[0].val.x;
    o.tfactor[1] = pcf_out[1].val.x;
    o.tfactor[2] = pcf_out[2].val.x;
    o.flInFactor = 4;

    return o;
}
