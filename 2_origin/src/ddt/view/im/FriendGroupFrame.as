package ddt.view.im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import im.CustomInfo;
   
   public class FriendGroupFrame extends Frame
   {
       
      
      private var _confirm:TextButton;
      
      private var _close:TextButton;
      
      private var _combox:ComboBox;
      
      public var nickName:String;
      
      private var _customList:Vector.<CustomInfo>;
      
      public function FriendGroupFrame()
      {
         var _loc4_:int = 0;
         super();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.addFriendFont");
         titleText = LanguageMgr.GetTranslation("AlertDialog.Info");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("friendGroupFrame.confirm");
         _confirm.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         _close = ComponentFactory.Instance.creatComponentByStylename("friendGroupFrame.close");
         _close.text = LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText");
         _combox = ComponentFactory.Instance.creatComponentByStylename("friendGroupFrame.choose");
         addToContent(_loc3_);
         addToContent(_confirm);
         addToContent(_close);
         addToContent(_combox);
         _combox.beginChanges();
         _combox.selctedPropName = "text";
         var _loc1_:VectorListModel = _combox.listPanel.vectorListModel;
         _loc1_.clear();
         _customList = PlayerManager.Instance.customList;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _customList.length - 1)
         {
            _loc2_.push(_customList[_loc4_].Name);
            _loc4_++;
         }
         _loc1_.appendAll(_loc2_);
         _combox.listPanel.list.updateListView();
         _combox.commitChanges();
         _combox.textField.text = _customList[0].Name;
         addEventListener("response",__responseHandler);
         _close.addEventListener("click",__clickHandler);
         _confirm.addEventListener("click",__confirmHandler);
         _combox.button.addEventListener("click",__buttonClick);
         _combox.listPanel.list.addEventListener("listItemClick",__itemClick);
      }
      
      protected function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         _loc2_ = 0;
         while(_loc2_ < _customList.length)
         {
            if(_customList[_loc2_].Name == _combox.textField.text)
            {
               SocketManager.Instance.out.sendAddFriend(nickName,_customList[_loc2_].ID);
               break;
            }
            _loc2_++;
         }
         dispose();
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      protected function __buttonClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         _close.removeEventListener("click",__clickHandler);
         _confirm.removeEventListener("click",__confirmHandler);
         _combox.button.removeEventListener("click",__buttonClick);
         _combox.listPanel.list.removeEventListener("listItemClick",__itemClick);
         _customList = null;
         if(_confirm)
         {
            ObjectUtils.disposeObject(_confirm);
         }
         _confirm = null;
         if(_close)
         {
            ObjectUtils.disposeObject(_close);
         }
         _close = null;
         if(_combox)
         {
            ObjectUtils.disposeObject(_combox);
         }
         _combox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         IMManager.Instance.clearGroupFrame();
      }
   }
}
