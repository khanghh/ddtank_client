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
         var i:int = 0;
         var j:int = 0;
         var item:* = null;
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
         for(i = 0; i < 4; )
         {
            itemList[i] = [];
            for(j = 0; j < 4; )
            {
               item = new CondiscountItem();
               box.addChild(item);
               var _loc6_:int = 0;
               var _loc5_:* = CondiscountManager.instance.model.giftbagArray;
               for each(var itemInfo in CondiscountManager.instance.model.giftbagArray)
               {
                  if(itemInfo.rewardMark == i && itemInfo.giftbagOrder == j)
                  {
                     item.setInfo(itemInfo);
                  }
               }
               itemList[i].push(item);
               item.x = i * 171 + 112;
               item.y = j * 109 + 112;
               j++;
            }
            i++;
         }
         setItemData();
      }
      
      private function setItemData() : void
      {
         var i:int = 0;
         var j:int = 0;
         var item:* = null;
         for(i = 0; i < 4; )
         {
            for(j = 0; j < 4; )
            {
               item = itemList[i][j];
               if(WonderfulActivityManager.Instance.activityInitData[item.info.activityId].giftInfoDic[item.info.giftbagId].times == 1)
               {
                  item.changeData(0);
               }
               else if(j == 0)
               {
                  item.changeData(2);
               }
               else
               {
                  var _loc6_:int = 0;
                  var _loc5_:* = CondiscountManager.instance.model.giftbagArray;
                  for each(var checkInfo in CondiscountManager.instance.model.giftbagArray)
                  {
                     if(checkInfo.rewardMark == i && checkInfo.giftbagOrder == j - 1)
                     {
                        if(WonderfulActivityManager.Instance.activityInitData[checkInfo.activityId].giftInfoDic[checkInfo.giftbagId].times == 1)
                        {
                           item.changeData(2);
                        }
                        else
                        {
                           item.changeData(1);
                        }
                     }
                  }
               }
               j++;
            }
            i++;
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
      
      private function refreshActivity(event:WonderfulActivityEvent = null) : void
      {
         setItemData();
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
