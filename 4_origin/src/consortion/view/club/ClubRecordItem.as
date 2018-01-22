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
      
      public function ClubRecordItem(param1:int)
      {
         super();
         _type = param1;
         init();
      }
      
      override public function get height() : Number
      {
         return RECORDITEM_HEIGHT;
      }
      
      private function init() : void
      {
         _name = ComponentFactory.Instance.creatComponentByStylename("club.recordItem.name");
         _contactChairmanBtn = ComponentFactory.Instance.creatComponentByStylename("club.contactChairmanBtn");
         _copyName = ComponentFactory.Instance.creatComponentByStylename("club.copyNameBtn");
         if(_type == 1)
         {
            _button = ComponentFactory.Instance.creatComponentByStylename("club.acceptInvent");
            _button.text = LanguageMgr.GetTranslation("club.acceptInvent.text");
         }
         else
         {
            _button = ComponentFactory.Instance.creatComponentByStylename("club.cancelApply");
            _button.text = LanguageMgr.GetTranslation("club.cancelApplyText");
            _copyName.addEventListener("click",__copyHandler);
            _contactChairmanBtn.addEventListener("click",__contactChairman);
            addChild(_contactChairmanBtn);
            addChild(_copyName);
         }
         _contactChairmanBtn.text = LanguageMgr.GetTranslation("club.contactChairmanBtnText");
         _copyName.text = LanguageMgr.GetTranslation("club.copyNameBtnText");
         addChild(_name);
         addChild(_button);
         _button.addEventListener("click",__clickHandler);
      }
      
      private function __copyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         System.setClipboard(_info.ChairmanName);
      }
      
      private function __contactChairman(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.alertPrivateFrame(_info.ChairmanID);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_type == 1)
         {
            SocketManager.Instance.out.sendConsortiaInvatePass(_info.ID);
         }
         else
         {
            SocketManager.Instance.out.sendConsortiaTryinDelete(_info.ID);
         }
      }
      
      public function set info(param1:*) : void
      {
         _info = param1;
         _name.text = param1.ConsortiaName;
      }
      
      public function dispose() : void
      {
         _button.removeEventListener("click",__clickHandler);
         if(_contactChairmanBtn)
         {
            _contactChairmanBtn.removeEventListener("click",__contactChairman);
            ObjectUtils.disposeObject(_contactChairmanBtn);
            _contactChairmanBtn = null;
         }
         if(_copyName)
         {
            _copyName.removeEventListener("click",__copyHandler);
            ObjectUtils.disposeObject(_copyName);
            _copyName = null;
         }
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_button)
         {
            ObjectUtils.disposeObject(_button);
         }
         _button = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
