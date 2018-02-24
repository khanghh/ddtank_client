package store.fineStore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class ForgeEffectItem extends Sprite implements Disposeable
   {
       
      
      private var _titleText:FilterFrameText;
      
      private var _content:Component;
      
      private var _stateText:FilterFrameText;
      
      public function ForgeEffectItem(param1:int, param2:String, param3:Array, param4:int){super();}
      
      private function creatStateText(param1:int) : void{}
      
      public function updateTipData(param1:int = 0) : void{}
      
      public function dispose() : void{}
   }
}
