package game.view.buff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class SkillBuffBar extends Sprite implements Disposeable
   {
      
      private static var PATH:String = "asset.game.skillBuff.icon";
       
      
      private var _iconDic:DictionaryData;
      
      private var _hBox:HBox;
      
      public function SkillBuffBar(){super();}
      
      public function addIcon(param1:int) : void{}
      
      public function removeIcon(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
