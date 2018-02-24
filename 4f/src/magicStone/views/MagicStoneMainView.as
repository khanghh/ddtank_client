package magicStone.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MagicStoneMainView extends Sprite implements Disposeable
   {
       
      
      private var _leftView:MagicStoneInfoView;
      
      private var _bagView:MagicStoneBagView;
      
      private var _btnHelp:BaseButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      public function MagicStoneMainView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function __helpClick(param1:MouseEvent) : void{}
      
      private function __helpFrameRespose(param1:FrameEvent) : void{}
      
      private function __closeHelpFrame(param1:MouseEvent) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
