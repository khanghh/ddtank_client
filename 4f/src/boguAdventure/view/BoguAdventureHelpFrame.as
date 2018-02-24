package boguAdventure.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BoguAdventureHelpFrame extends Sprite implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _bg:Bitmap;
      
      private var _box:Sprite;
      
      private var _helpBtn:SelectedButton;
      
      private var _flag:Boolean;
      
      public function BoguAdventureHelpFrame(){super();}
      
      private function init() : void{}
      
      private function __onHelpClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
