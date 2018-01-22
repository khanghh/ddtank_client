package drgnBoat.views
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import store.HelpFrame;
   
   public class DrgnBoatHelpBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      public function DrgnBoatHelpBtn(param1:Boolean = true){super();}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void{}
      
      public function dispose() : void{}
   }
}
