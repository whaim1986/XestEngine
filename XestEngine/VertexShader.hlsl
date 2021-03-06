////--------------------------------------------------------------------------------------
//// Constant Buffer Variables
////--------------------------------------------------------------------------------------
//cbuffer ConstantBuffer : register(b0)
//{
//	matrix World;
//	matrix View;
//	matrix Projection;
//}
//
////--------------------------------------------------------------------------------------
//struct VS_OUTPUT
//{
//	float4 Pos : SV_POSITION;
//	float4 Color : COLOR0;
//};
//
//
////--------------------------------------------------------------------------------------
//// Vertex Shader
////--------------------------------------------------------------------------------------
//VS_OUTPUT main(float4 Pos : POSITION, float4 Color : COLOR)
//{
//	VS_OUTPUT output = (VS_OUTPUT)0;
//	output.Pos = mul(Pos, World);
//	output.Pos = mul(output.Pos, View);
//	output.Pos = mul(output.Pos, Projection);
//	output.Color = Color;
//	return output;
//}







// 存储用于组合几何图形的三个基本列优先矩阵的常量缓冲区。
cbuffer ModelViewProjectionConstantBuffer : register(b0)
{
	matrix model;
	matrix view;
	matrix projection;
};

// 用作对顶点着色器的输入的每个顶点的数据。
struct VertexShaderInput
{
	float3 pos : POSITION;
	float3 color : COLOR0;
};

// 通过像素着色器传递的每个像素的颜色数据。
struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float3 color : COLOR0;
};

// 用于在 GPU 上执行顶点处理的简单着色器。
PixelShaderInput main(VertexShaderInput input)
{
	PixelShaderInput output;
	float4 pos = float4(input.pos, 1.0f);

		// 将顶点位置转换为投影空间。
		pos = mul(pos, model);
	pos = mul(pos, view);
	pos = mul(pos, projection);
	output.pos = pos;

	// 不加修改地传递颜色。
	output.color = input.color;

	return output;
}
