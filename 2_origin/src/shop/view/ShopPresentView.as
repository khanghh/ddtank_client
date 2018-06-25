package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatFriendListPanel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.ShopController;
   
   public class ShopPresentView extends Sprite
   {
       
      
      private var _frame:BaseAlerFrame;
      
      private var _friendList:ChatFriendListPanel;
      
      private var _comBtn:BaseButton;
      
      private var _controller:ShopController;
      
      private var _bg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _textArea:TextArea;
      
      public function ShopPresentView()
      {
         super();
      }
      
      public function setup(controller:ShopController) : void
      {
         _controller = controller;
         init();
      }
      
      private function init() : void
      {
         _friendList = new ChatFriendListPanel();
         _frame = ComponentFactory.Instance.creatComponentByStylename("shop.PresentViewFrame");
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.PresentBg");
         _comBtn = ComponentFactory.Instance.creatComponentByStylename("shop.PresentViewCombo");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PresentViewFriendName");
         _textArea = ComponentFactory.Instance.creatComponentByStylename("shop.PresentViewTextArea");
         var ai:AlertInfo = new AlertInfo("",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         ai.moveEnable = false;
         _frame.info = ai;
         PositionUtils.setPos(_friendList,"shop.PresentViewFriendListPos");
         _nameTxt.maxChars = 25;
         _friendList.visible = false;
         _friendList.setup(doSelected);
         _textArea.maxChars = 300;
         _frame.addToContent(_bg);
         _frame.addToContent(_nameTxt);
         _frame.addToContent(_textArea);
         _frame.addToContent(_friendList);
         _frame.addToContent(_comBtn);
         _comBtn.addEventListener("click",__comBtnClickHandler);
         _frame.addEventListener("response",__frameEventHandler);
         addChild(_frame);
      }
      
      private function __comBtnClickHandler(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
         SoundManager.instance.play("008");
         _friendList.visible = true;
         _frame.addToContent(_friendList);
      }
      
      private function __frameEventHandler(e:FrameEvent) : void
      {
         var str:* = null;
         SoundManager.instance.play("008");
         switch(int(e.responseCode) - 2)
         {
            case 0:
            case 1:
               str = FilterWordManager.filterWrod(_textArea.text);
               if(_nameTxt.text == "")
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.give"));
                  return;
               }
               if(FilterWordManager.IsNullorEmpty(_nameTxt.text))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.space"));
                  return;
               }
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               _controller.presentItems(_controller.model.allItems,str,_nameTxt.text);
               _controller.model.clearAllitems();
               break;
         }
         dispose();
      }
      
      private function doSelected(nick:String, id:Number = 0) : void
      {
         _nameTxt.text = nick;
         if(_friendList.parent)
         {
            _friendList.parent.removeChild(_friendList);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function dispose() : void
      {
         _comBtn.removeEventListener("click",__comBtnClickHandler);
         _frame.dispose();
         _frame = null;
         _friendList = null;
         _comBtn = null;
         _bg = null;
         _nameTxt = null;
         _textArea = null;
      }
   }
}
