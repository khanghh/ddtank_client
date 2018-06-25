package magicStone.components{   import ddt.data.goods.ItemTemplateInfo;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class EmbedMgStoneCell extends MgStoneCell   {                   public function EmbedMgStoneCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null) { super(null,null,null,null); }
            override public function set info(value:ItemTemplateInfo) : void { }
            private function getNameTxtColor(quality:int) : uint { return null; }
            override protected function updateSize(sp:Sprite) : void { }
            override public function dispose() : void { }
   }}