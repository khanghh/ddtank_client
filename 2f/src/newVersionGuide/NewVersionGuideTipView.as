package newVersionGuide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.OpitionEnum;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NewVersionGuideTipView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _contentBit:Bitmap;
      
      private var _btn:TextButton;
      
      private var _completeGuideFunc:Function;
      
      private var _type:int;
      
      public function NewVersionGuideTipView(param1:int, param2:Function = null){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __clickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
