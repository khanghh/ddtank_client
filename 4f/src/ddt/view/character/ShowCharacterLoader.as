package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   
   public class ShowCharacterLoader extends BaseCharacterLoader
   {
       
      
      protected var _contentWithoutWeapon:BitmapData;
      
      private var _needMultiFrames:Boolean = false;
      
      public function ShowCharacterLoader(param1:PlayerInfo){super(null);}
      
      override protected function initLayers() : void{}
      
      private function loadPart(param1:int) : void{}
      
      private function laodArm() : void{}
      
      override protected function getIndexByTemplateId(param1:String) : int{return 0;}
      
      public function set needMultiFrames(param1:Boolean) : void{}
      
      override protected function drawCharacter() : void{}
      
      override public function dispose() : void{}
      
      public function destory() : void{}
      
      override public function getContent() : Array{return null;}
   }
}
