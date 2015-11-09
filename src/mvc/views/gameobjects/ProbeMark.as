package tercia.create
{
	import flash.display.*;

	public class ProbeMark extends Sprite
	{
		public function ProbeMark()
		{
			const size:Number = 6;
			const offset:Number = .5;
			graphics.beginFill(0x5E1111, .7);
			graphics.moveTo(offset, offset);
			graphics.lineTo(size + offset, offset);
			graphics.lineTo(offset, size + offset);
			graphics.lineTo(offset, offset);
		}
	}
}
