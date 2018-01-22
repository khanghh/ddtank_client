package oldPlayerRegress.view.itemView.call
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class CallLookUpView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _cleanUpBtn:BaseButton;
      
      private var _inputText:TextInput;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _list:VBox;
      
      private var _NAN:FilterFrameText;
      
      private var _lookBtn:Bitmap;
      
      public function CallLookUpView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("call.inputBg");
         addChild(_bg);
         _lookBtn = ComponentFactory.Instance.creatBitmap("asset.core.searchIcon");
         PositionUtils.setPos(_lookBtn,"regress.call.lookBtn.pos");
         addChild(_lookBtn);
         _inputText = ComponentFactory.Instance.creatComponentByStylename("call.textinput");
         addChild(_inputText);
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("call.Lookup.lookUpBG");
         _bg2.visible = false;
         addChild(_bg2);
         _list = ComponentFactory.Instance.creat("call.Lookup.lookupList");
         addChild(_list);
         _cleanUpBtn = ComponentFactory.Instance.creatComponentByStylename("call.cleanUpBtn");
         _cleanUpBtn.visible = false;
         addChild(_cleanUpBtn);
         _NAN = ComponentFactory.Instance.creatComponentByStylename("IM.IMLookup.IMLookupItemName");
         _NAN.text = LanguageMgr.GetTranslation("ddt.FriendDropListCell.noFriend");
         _NAN.visible = false;
         _NAN.x = _bg2.x + 10;
         _NAN.y = _bg2.y + 7;
         addChild(_NAN);
      }
      
      private function initEvent() : void
      {
         inputText.addEventListener("change",__textInput);
      }
      
      private function __textInput(param1:Event) : void
      {
      }
      
      private function removeEvent() : void
      {
         if(inputText)
         {
            inputText.removeEventListener("change",__textInput);
         }
      }
      
      private function hide() : void
      {
         _bg2.visible = false;
         _NAN.visible = false;
         _cleanUpBtn.visible = false;
         _list.visible = false;
         _lookBtn.visible = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg2)
         {
            _bg2.dispose();
            _bg2 = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_cleanUpBtn)
         {
            _cleanUpBtn.dispose();
            _cleanUpBtn = null;
         }
         if(inputText)
         {
            inputText.dispose();
            inputText = null;
         }
         if(_list)
         {
            _list.dispose();
            _list = null;
         }
         if(_NAN)
         {
            ObjectUtils.disposeObject(_NAN);
            _NAN = null;
         }
         if(_lookBtn)
         {
            _lookBtn = null;
         }
      }
      
      public function get inputText() : TextInput
      {
         return _inputText;
      }
      
      public function set inputText(param1:TextInput) : void
      {
         _inputText = param1;
      }
   }
}
