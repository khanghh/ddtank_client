package hall.player
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HallPlayerTips extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _addFriend:IconButton;
      
      private var _privateChat:IconButton;
      
      private var _viewInfo:IconButton;
      
      private var _nickName:String;
      
      private var _id:int;
      
      public function HallPlayerTips()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.tipsBg");
         addChild(_bg);
         _addFriend = ComponentFactory.Instance.creatComponentByStylename("hall.playerTip.itemmakeFriend");
         addChild(_addFriend);
         _privateChat = ComponentFactory.Instance.creatComponentByStylename("hall.playerTip.privateChat");
         addChild(_privateChat);
         _viewInfo = ComponentFactory.Instance.creatComponentByStylename("hall.playerTip.viewInfo");
         addChild(_viewInfo);
      }
      
      private function initEvent() : void
      {
         _addFriend.addEventListener("click",__onAddFriend);
         _privateChat.addEventListener("click",__onPrivateChat);
         _viewInfo.addEventListener("click",__onViewInfo);
      }
      
      public function setInfo(nickName:String, id:int) : void
      {
         _nickName = nickName;
         _id = id;
      }
      
      protected function __onViewInfo(event:MouseEvent) : void
      {
         PlayerInfoViewControl.viewByID(_id,-1,true,false);
         PlayerInfoViewControl.isOpenFromBag = false;
         this.visible = false;
      }
      
      protected function __onPrivateChat(event:MouseEvent) : void
      {
         ChatManager.Instance.privateChatTo(_nickName,_id);
         this.visible = false;
      }
      
      protected function __onAddFriend(event:MouseEvent) : void
      {
         IMManager.Instance.addFriend(_nickName);
         this.visible = false;
      }
      
      private function removeEvent() : void
      {
         _addFriend.removeEventListener("click",__onAddFriend);
         _privateChat.removeEventListener("click",__onPrivateChat);
         _viewInfo.removeEventListener("click",__onViewInfo);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_addFriend)
         {
            ObjectUtils.disposeObject(_addFriend);
         }
         _addFriend = null;
         if(_privateChat)
         {
            ObjectUtils.disposeObject(_privateChat);
         }
         _privateChat = null;
         if(_viewInfo)
         {
            ObjectUtils.disposeObject(_viewInfo);
         }
         _viewInfo = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
