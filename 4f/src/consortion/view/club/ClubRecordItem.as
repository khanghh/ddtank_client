package consortion.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.System;
   
   public class ClubRecordItem extends Sprite implements Disposeable
   {
      
      private static var RECORDITEM_HEIGHT:int = 30;
       
      
      private var _info;
      
      private var _type:int;
      
      private var _name:FilterFrameText;
      
      private var _button:TextButton;
      
      private var _contactChairmanBtn:TextButton;
      
      private var _copyName:TextButton;
      
      public function ClubRecordItem(param1:int){super();}
      
      override public function get height() : Number{return 0;}
      
      private function init() : void{}
      
      private function __copyHandler(param1:MouseEvent) : void{}
      
      private function __contactChairman(param1:MouseEvent) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      public function set info(param1:*) : void{}
      
      public function dispose() : void{}
   }
}
