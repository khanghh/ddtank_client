package condiscount.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import condiscount.CondiscountManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.event.WonderfulActivityEvent;
   
   public class CondiscountFrame extends Frame
   {
       
      
      private var _timeTxt:FilterFrameText;
      
      private var _2dis:Bitmap;
      
      private var _3dis:Bitmap;
      
      private var _4dis:Bitmap;
      
      private var _5dis:Bitmap;
      
      private var itemList:Array;
      
      private var box:Sprite;
      
      private var _helpBtn:BaseButton;
      
      public function CondiscountFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("condiscount.view.timeText");
         addToContent(_timeTxt);
         _timeTxt.text = LanguageMgr.GetTranslation("ddt.condiscount.view.time",CondiscountManager.instance.model.beginTime,CondiscountManager.instance.model.endTime);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"condiscount.view.helpbtn",{
            "x":743,
            "y":50
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"condiscount.content.help",438,520);
         _2dis = ComponentFactory.Instance.creatBitmap("condiscount.view.2discount");
         _3dis = ComponentFactory.Instance.creatBitmap("condiscount.view.3discount");
         _4dis = ComponentFactory.Instance.creatBitmap("condiscount.view.4discount");
         _5dis = ComponentFactory.Instance.creatBitmap("condiscount.view.5discount");
         addToContent(_2dis);
         addToContent(_3dis);
         addToContent(_4dis);
         addToContent(_5dis);
         itemList = [];
         box = new Sprite();
         addToContent(box);
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            itemList[_loc4_] = [];
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _loc1_ = new CondiscountItem();
               box.addChild(_loc1_);
               var _loc6_:int = 0;
               var _loc5_:* = CondiscountManager.instance.model.giftbagArray;
               for each(var _loc2_ in CondiscountManager.instance.model.giftbagArray)
               {
                  if(_loc2_.rewardMark == _loc4_ && _loc2_.giftbagOrder == _loc3_)
                  {
                     _loc1_.setInfo(_loc2_);
                  }
               }
               itemList[_loc4_].push(_loc1_);
               _loc1_.x = _loc4_ * 171 + 112;
               _loc1_.y = _loc3_ * 109 + 112;
               _loc3_++;
            }
            _loc4_++;
         }
         setItemData();
      }
      
      private function setItemData() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _loc2_ = itemList[_loc4_][_loc3_];
               if(WonderfulActivityManager.Instance.activityInitData[_loc2_.info.activityId].giftInfoDic[_loc2_.info.giftbagId].times == 1)
               {
                  _loc2_.changeData(0);
               }
               else if(_loc3_ == 0)
               {
                  _loc2_.changeData(2);
               }
               else
               {
                  var _loc6_:int = 0;
                  var _loc5_:* = CondiscountManager.instance.model.giftbagArray;
                  for each(var _loc1_ in CondiscountManager.instance.model.giftbagArray)
                  {
                     if(_loc1_.rewardMark == _loc4_ && _loc1_.giftbagOrder == _loc3_ - 1)
                     {
                        if(WonderfulActivityManager.Instance.activityInitData[_loc1_.activityId].giftInfoDic[_loc1_.giftbagId].times == 1)
                        {
                           _loc2_.changeData(2);
                        }
                        else
                        {
                           _loc2_.changeData(1);
                        }
                     }
                  }
               }
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
         WonderfulActivityManager.Instance.removeEventListener("refresh",refreshActivity);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
         WonderfulActivityManager.Instance.addEventListener("refresh",refreshActivity);
      }
      
      private function refreshActivity(param1:WonderfulActivityEvent = null) : void
      {
         setItemData();
      }
      
      protected function _responseHandle(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_5dis);
         _5dis = null;
         ObjectUtils.disposeObject(_4dis);
         _4dis = null;
         ObjectUtils.disposeObject(_3dis);
         _3dis = null;
         ObjectUtils.disposeObject(_2dis);
         _2dis = null;
         ObjectUtils.disposeObject(box);
         box = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         itemList = null;
      }
   }
}
