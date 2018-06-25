package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import im.CustomInfo;
   
   public class FriendGroupTItem extends Sprite implements Disposeable
   {
       
      
      private var _text:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _info:CustomInfo;
      
      private var _nickName:String;
      
      public function FriendGroupTItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.FriendGroupTItem.bg");
         _text = ComponentFactory.Instance.creatComponentByStylename("GroupTItem.text");
         addChild(_bg);
         addChild(_text);
         _bg.visible = false;
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         addEventListener("click",__clickHandler);
      }
      
      public function set info(info:CustomInfo) : void
      {
         _info = info;
         _text.text = _info.Name;
      }
      
      public function set NickName(str:String) : void
      {
         _nickName = str;
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         _bg.visible = true;
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         _bg.visible = false;
      }
      
      protected function __clickHandler(event:MouseEvent) : void
      {
         SocketManager.Instance.out.sendAddFriend(_nickName,_info.ID);
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         removeEventListener("click",__clickHandler);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_text)
         {
            ObjectUtils.disposeObject(_text);
         }
         _text = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
