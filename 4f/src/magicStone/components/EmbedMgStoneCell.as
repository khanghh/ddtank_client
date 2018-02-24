package magicStone.components
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class EmbedMgStoneCell extends MgStoneCell
   {
       
      
      public function EmbedMgStoneCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null){super(null,null,null,null);}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      private function getNameTxtColor(param1:int) : uint{return null;}
      
      override protected function updateSize(param1:Sprite) : void{}
      
      override public function dispose() : void{}
   }
}
