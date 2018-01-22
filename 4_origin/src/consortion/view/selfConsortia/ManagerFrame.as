package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaAssetLevelOffer;
   import consortion.event.ConsortionEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ManagerFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _consortionShop:Bitmap;
      
      private var _consortionStore:Bitmap;
      
      private var _consortionSkill:Bitmap;
      
      private var _contributionText1:FilterFrameText;
      
      private var _contributionText2:FilterFrameText;
      
      private var _contributionText3:FilterFrameText;
      
      private var _contributionText4:FilterFrameText;
      
      private var _contributionText5:FilterFrameText;
      
      private var _contributionText6:FilterFrameText;
      
      private var _contributionText7:FilterFrameText;
      
      private var _noticeText:FilterFrameText;
      
      private var _inputBG:MutipleImage;
      
      private var _textBG:MutipleImage;
      
      private var _taxBtn:TextButton;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _shopLevelTxt1:TextInput;
      
      private var _shopLevelTxt2:TextInput;
      
      private var _shopLevelTxt3:TextInput;
      
      private var _shopLevelTxt4:TextInput;
      
      private var _shopLevelTxt5:TextInput;
      
      private var _smithTxt:TextInput;
      
      private var _skillTxt:TextInput;
      
      private var _valueArray:Array;
      
      public function ManagerFrame()
      {
         _valueArray = [100,100,100,100,100,100,100];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.ConsortiaAssetManagerFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.bg");
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.inputBG");
         _textBG = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.textBG");
         _consortionShop = ComponentFactory.Instance.creatBitmap("asset.consortion.ConsortiaAssetManagerFrame.consortionShop");
         _consortionStore = ComponentFactory.Instance.creatBitmap("asset.consortion.ConsortiaAssetManagerFrame.consortionStore");
         _consortionSkill = ComponentFactory.Instance.creatBitmap("asset.consortion.ConsortiaAssetManagerFrame.consortionSkill");
         _contributionText1 = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.contributionText1");
         _contributionText2 = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.contributionText2");
         _contributionText3 = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.contributionText3");
         _contributionText4 = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.contributionText4");
         _contributionText5 = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.contributionText5");
         _contributionText6 = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.contributionText6");
         _contributionText7 = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.contributionText7");
         _taxBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.offerBtn");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.okBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.cancelBtn");
         _shopLevelTxt1 = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.shopLevelTxt1");
         _shopLevelTxt2 = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.shopLevelTxt2");
         _shopLevelTxt3 = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.shopLevelTxt3");
         _shopLevelTxt4 = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.shopLevelTxt4");
         _shopLevelTxt5 = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.shopLevelTxt5");
         _smithTxt = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.smithTxt");
         _skillTxt = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame.skillTxt");
         _noticeText = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortiaAssetManagerFrame.noticeText");
         addToContent(_bg);
         addToContent(_inputBG);
         addToContent(_textBG);
         addToContent(_consortionShop);
         addToContent(_consortionStore);
         addToContent(_consortionSkill);
         addToContent(_contributionText1);
         addToContent(_contributionText2);
         addToContent(_contributionText3);
         addToContent(_contributionText4);
         addToContent(_contributionText5);
         addToContent(_contributionText6);
         addToContent(_contributionText7);
         addToContent(_taxBtn);
         addToContent(_okBtn);
         addToContent(_cancelBtn);
         addToContent(_shopLevelTxt1);
         addToContent(_shopLevelTxt2);
         addToContent(_shopLevelTxt3);
         addToContent(_shopLevelTxt4);
         addToContent(_shopLevelTxt5);
         addToContent(_smithTxt);
         addToContent(_skillTxt);
         addToContent(_noticeText);
         _contributionText1.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.contributionText1");
         _contributionText2.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.contributionText2");
         _contributionText3.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.contributionText3");
         _contributionText4.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.contributionText4");
         _contributionText5.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.contributionText5");
         _contributionText6.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.contributionText6");
         _contributionText7.text = _contributionText6.text;
         _noticeText.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.noticeText");
         _taxBtn.text = LanguageMgr.GetTranslation("consortion.ConsortiaAssetManagerFrame.facilityDonate");
         _okBtn.text = LanguageMgr.GetTranslation("ok");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         if(PlayerManager.Instance.Self.DutyLevel == 1)
         {
            inputText(_shopLevelTxt1);
            inputText(_shopLevelTxt2);
            inputText(_shopLevelTxt3);
            inputText(_shopLevelTxt4);
            inputText(_shopLevelTxt5);
            inputText(_smithTxt);
            inputText(_skillTxt);
         }
         else
         {
            DynamicText(_shopLevelTxt1);
            DynamicText(_shopLevelTxt2);
            DynamicText(_shopLevelTxt3);
            DynamicText(_shopLevelTxt4);
            DynamicText(_shopLevelTxt5);
            DynamicText(_smithTxt);
            DynamicText(_skillTxt);
         }
         _shopLevelTxt1.text = LanguageMgr.GetTranslation("hundred");
         _shopLevelTxt2.text = LanguageMgr.GetTranslation("hundred");
         _shopLevelTxt3.text = LanguageMgr.GetTranslation("hundred");
         _shopLevelTxt4.text = LanguageMgr.GetTranslation("hundred");
         _shopLevelTxt5.text = LanguageMgr.GetTranslation("hundred");
         _smithTxt.text = LanguageMgr.GetTranslation("hundred");
         _skillTxt.text = LanguageMgr.GetTranslation("hundred");
      }
      
      private function inputText(param1:TextInput) : void
      {
         param1.textField.restrict = "0-9";
         param1.textField.maxChars = 8;
         param1.mouseChildren = true;
         param1.mouseEnabled = true;
         param1.textField.selectable = true;
      }
      
      private function DynamicText(param1:TextInput) : void
      {
         param1.textField.selectable = false;
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _okBtn.addEventListener("click",__okHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _taxBtn.addEventListener("click",__taxHandler);
         ConsortionModelManager.Instance.model.addEventListener("useConditionChange",__conditionChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _okBtn.removeEventListener("click",__okHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _taxBtn.removeEventListener("click",__taxHandler);
         ConsortionModelManager.Instance.model.removeEventListener("useConditionChange",__conditionChangeHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __okHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked && checkChange())
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.DutyLevel == 1)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.ConsortiaAssetManagerFrame.okFunction"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc2_.addEventListener("response",__alertResponse);
         }
         else
         {
            dispose();
         }
      }
      
      private function checkChange() : Boolean
      {
         var _loc10_:int = 0;
         var _loc7_:int = checkInputValue(_shopLevelTxt1);
         var _loc2_:int = checkInputValue(_shopLevelTxt2);
         var _loc1_:int = checkInputValue(_shopLevelTxt3);
         var _loc5_:int = checkInputValue(_shopLevelTxt4);
         var _loc4_:int = checkInputValue(_shopLevelTxt5);
         var _loc9_:int = checkInputValue(_smithTxt);
         var _loc3_:int = checkInputValue(_skillTxt);
         var _loc6_:Array = [_loc7_,_loc2_,_loc1_,_loc5_,_loc4_,_loc9_,_loc3_];
         var _loc8_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < 7)
         {
            if(_valueArray[_loc10_] != _loc6_[_loc10_])
            {
               _loc8_ = true;
            }
            _loc10_++;
         }
         return _loc8_;
      }
      
      private function __alertResponse(param1:FrameEvent) : void
      {
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__alertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
         if((param1.responseCode == 3 || param1.responseCode == 2) && checkChange())
         {
            _loc8_ = checkInputValue(_shopLevelTxt1);
            _loc3_ = checkInputValue(_shopLevelTxt2);
            _loc2_ = checkInputValue(_shopLevelTxt3);
            _loc6_ = checkInputValue(_shopLevelTxt4);
            _loc5_ = checkInputValue(_shopLevelTxt5);
            _loc9_ = checkInputValue(_smithTxt);
            _loc4_ = checkInputValue(_skillTxt);
            _loc7_ = [_loc8_,_loc3_,_loc2_,_loc6_,_loc5_,_loc9_,_loc4_];
            SocketManager.Instance.out.sendConsortiaEquipConstrol(_loc7_);
         }
      }
      
      private function checkInputValue(param1:TextInput) : int
      {
         if(param1.text == "")
         {
            return 0;
         }
         return int(param1.text);
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __taxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ConsortionModelManager.Instance.alertTaxFrame();
      }
      
      private function __conditionChangeHandler(param1:ConsortionEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<ConsortiaAssetLevelOffer> = ConsortionModelManager.Instance.model.useConditionList;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].Type == 1)
            {
               switch(int(_loc2_[_loc4_].Level) - 1)
               {
                  case 0:
                     var _loc5_:String = _loc2_[_loc4_].Riches;
                     _valueArray[0] = _loc5_;
                     _shopLevelTxt1.text = _loc5_;
                     break;
                  case 1:
                     _loc5_ = _loc2_[_loc4_].Riches;
                     _valueArray[1] = _loc5_;
                     _shopLevelTxt2.text = _loc5_;
                     break;
                  case 2:
                     _loc5_ = _loc2_[_loc4_].Riches;
                     _valueArray[2] = _loc5_;
                     _shopLevelTxt3.text = _loc5_;
                     break;
                  case 3:
                     _loc5_ = _loc2_[_loc4_].Riches;
                     _valueArray[3] = _loc5_;
                     _shopLevelTxt4.text = _loc5_;
                     break;
                  case 4:
                     _loc5_ = _loc2_[_loc4_].Riches;
                     _valueArray[4] = _loc5_;
                     _shopLevelTxt5.text = _loc5_;
               }
            }
            else if(_loc2_[_loc4_].Type == 2)
            {
               _loc5_ = _loc2_[_loc4_].Riches;
               _valueArray[5] = _loc5_;
               _smithTxt.text = _loc5_;
            }
            else if(_loc2_[_loc4_].Type == 3)
            {
               _loc5_ = _loc2_[_loc4_].Riches;
               _valueArray[6] = _loc5_;
               _skillTxt.text = _loc5_;
            }
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _inputBG = null;
         _textBG = null;
         if(_consortionShop)
         {
            ObjectUtils.disposeObject(_consortionShop);
            _consortionShop.bitmapData.dispose();
         }
         _consortionShop = null;
         if(_consortionStore)
         {
            ObjectUtils.disposeObject(_consortionStore);
            _consortionStore.bitmapData.dispose();
         }
         _consortionStore = null;
         if(_consortionSkill)
         {
            ObjectUtils.disposeObject(_consortionSkill);
            _consortionSkill.bitmapData.dispose();
         }
         _consortionSkill = null;
         _contributionText1 = null;
         _contributionText2 = null;
         _contributionText3 = null;
         _contributionText4 = null;
         _contributionText5 = null;
         _contributionText6 = null;
         _contributionText7 = null;
         _noticeText = null;
         _taxBtn = null;
         _okBtn = null;
         _cancelBtn = null;
         _shopLevelTxt1 = null;
         _shopLevelTxt2 = null;
         _shopLevelTxt3 = null;
         _shopLevelTxt4 = null;
         _shopLevelTxt5 = null;
         _smithTxt = null;
         _skillTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
