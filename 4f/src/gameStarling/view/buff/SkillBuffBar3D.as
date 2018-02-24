package gameStarling.view.buff
{
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import starling.display.Image;
   import starling.display.Sprite;
   import starlingui.core.components.HBox;
   
   public class SkillBuffBar3D extends Sprite
   {
      
      private static var PATH:String = "game_skillBuff_icon";
       
      
      private var _iconDic:DictionaryData;
      
      private var _hBox:HBox;
      
      public function SkillBuffBar3D(){super();}
      
      public function addIcon(param1:int) : void{}
      
      public function removeIcon(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
