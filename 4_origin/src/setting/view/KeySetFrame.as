package setting.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class KeySetFrame extends BaseAlerFrame
   {
       
      
      private var _list:HBox;
      
      private var _defaultSetPalel:KeyDefaultSetPanel;
      
      private var _currentSet:KeySetItem;
      
      private var _tempSets:Dictionary;
      
      private var numberAccect:Bitmap;
      
      private var _submit:TextButton;
      
      private var _cancel:TextButton;
      
      private var _imageRectString:String;
      
      public function KeySetFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("tank.view.bagII.KeySetFrame.titleText");
         initContent();
         addEvent();
         this.escEnable = true;
      }
      
      private function initContent() : void
      {
         numberAccect = ComponentFactory.Instance.creatBitmap("ddtsetting.keyset.numAsset");
         _list = ComponentFactory.Instance.creatComponentByStylename("keySetHBox");
         _tempSets = new Dictionary();
         var _loc3_:int = 0;
         var _loc2_:* = SharedManager.Instance.GameKeySets;
         for(var _loc1_ in SharedManager.Instance.GameKeySets)
         {
            _tempSets[_loc1_] = SharedManager.Instance.GameKeySets[_loc1_];
         }
         _submit = ComponentFactory.Instance.creatComponentByStylename("setting.KeySet.SubmitButton");
         _submit.text = LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm");
         addToContent(_submit);
         _cancel = ComponentFactory.Instance.creatComponentByStylename("setting.KeySet.CancelButton");
         _cancel.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_cancel);
         creatCell();
         addToContent(_list);
         addToContent(numberAccect);
         _defaultSetPalel = new KeyDefaultSetPanel();
         _defaultSetPalel.visible = false;
         _defaultSetPalel.addEventListener("select",onItemSelected);
         _defaultSetPalel.addEventListener("removedFromStage",__ondefaultSetRemove);
         if(_imageRectString != null)
         {
            MutipleImage(_backgound).imageRectString = _imageRectString;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _submit.addEventListener("click",__onSubmit);
         _cancel.addEventListener("click",__onCancel);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _submit.removeEventListener("click",__onSubmit);
         _cancel.removeEventListener("click",__onCancel);
      }
      
      private function __onSubmit(param1:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(2));
      }
      
      private function __onCancel(param1:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(1));
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               cancelClick();
               break;
            case 2:
            case 3:
            case 4:
               okClick();
         }
      }
      
      private function okClick() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _tempSets;
         for(var _loc1_ in _tempSets)
         {
            SharedManager.Instance.GameKeySets[_loc1_] = _tempSets[_loc1_];
         }
         SharedManager.Instance.save();
      }
      
      private function onItemClick(param1:ItemEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         _currentSet = param1.currentTarget as KeySetItem;
         if(_defaultSetPalel.parent)
         {
            removeChild(_defaultSetPalel);
         }
         _defaultSetPalel.visible = true;
         _currentSet.glow = true;
         _defaultSetPalel.x = param1.currentTarget.x + 2;
         _defaultSetPalel.y = _list.y - _defaultSetPalel.height;
         addChild(_defaultSetPalel);
      }
      
      private function cancelClick() : void
      {
         _tempSets = new Dictionary();
         var _loc3_:int = 0;
         var _loc2_:* = SharedManager.Instance.GameKeySets;
         for(var _loc1_ in SharedManager.Instance.GameKeySets)
         {
            _tempSets[_loc1_] = SharedManager.Instance.GameKeySets[_loc1_];
         }
         clearItemList();
      }
      
      private function __ondefaultSetRemove(param1:Event) : void
      {
         if(_currentSet)
         {
            _currentSet.glow = false;
         }
      }
      
      private function creatCell() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         clearItemList();
         var _loc5_:int = 0;
         var _loc4_:* = _tempSets;
         for(var _loc3_ in _tempSets)
         {
            _loc2_ = ItemManager.Instance.getTemplateById(_tempSets[_loc3_]);
            if(_loc3_ == "9")
            {
               return;
            }
            if(_loc2_)
            {
               _loc1_ = new KeySetItem(int(_loc3_),int(_loc3_),_tempSets[_loc3_],PropItemView.createView(_loc2_.Pic,40,40));
               _loc1_.addEventListener("itemClick",onItemClick);
               _loc1_.setClick(true,false,true);
               _list.addChild(_loc1_);
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,2);
         StageReferance.stage.focus = this;
      }
      
      private function clearItemList(param1:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_list)
         {
            _loc3_ = 0;
            while(_loc3_ < _list.numChildren)
            {
               _loc2_ = KeySetItem(_list.getChildAt(_loc3_));
               _loc2_.removeEventListener("itemClick",onItemClick);
               _loc2_.dispose();
               _loc2_ = null;
               _loc3_++;
            }
            ObjectUtils.disposeAllChildren(_list);
            if(param1)
            {
               if(_list.parent)
               {
                  _list.parent.removeChild(_list);
               }
               _list = null;
            }
         }
      }
      
      public function close() : void
      {
         _defaultSetPalel.hide();
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function onItemSelected(param1:Event) : void
      {
         if(stage)
         {
            stage.focus = this;
         }
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_defaultSetPalel.selectedItemID);
         _currentSet.setItem(PropItemView.createView(_loc2_.Pic,40,40),false);
         _currentSet.propID = _defaultSetPalel.selectedItemID;
         _tempSets[_currentSet.index] = _defaultSetPalel.selectedItemID;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearItemList(true);
         _defaultSetPalel.removeEventListener("select",onItemSelected);
         _defaultSetPalel.removeEventListener("removedFromStage",__ondefaultSetRemove);
         _defaultSetPalel.dispose();
         _defaultSetPalel = null;
         ObjectUtils.disposeObject(numberAccect);
         numberAccect = null;
         ObjectUtils.disposeObject(_submit);
         _submit = null;
         ObjectUtils.disposeObject(_cancel);
         _cancel = null;
         if(_currentSet)
         {
            _currentSet.removeEventListener("itemClick",onItemClick);
            _currentSet.dispose();
            _currentSet = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_list);
         _list = null;
         super.dispose();
      }
      
      public function set imageRectString(param1:String) : void
      {
         _imageRectString = param1;
         if(_backgound)
         {
            MutipleImage(_backgound).imageRectString = _imageRectString;
         }
      }
      
      public function get imageRectString() : String
      {
         return _imageRectString;
      }
   }
}
