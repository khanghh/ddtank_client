package firstRecharge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import firstRecharge.FirstRechargeControl;
   import firstRecharge.FirstRechargeManger;
   import firstRecharge.data.RechargeData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class FirstTouchView extends Frame implements Disposeable
   {
       
      
      private var _treeImage:ScaleBitmapImage;
      
      private var _treeImage2:ScaleBitmapImage;
      
      private var _worldtitle:Bitmap;
      
      private var _child:Bitmap;
      
      private var _back:MutipleImage;
      
      private var _btn:SimpleBitmapButton;
      
      private var _goodsContentList:Vector.<BagCell>;
      
      private var _line:Bitmap;
      
      private var _cartoonList:Vector.<MovieClip>;
      
      private var _rechargeMoneyTotalText:GradientText;
      
      private var _rechargeGiftBagValueText1:GradientText;
      
      private var _rechargeGiftBagValueText2:GradientText;
      
      private var _wordDirept:FilterFrameText;
      
      private var _wordDirept2:FilterFrameText;
      
      private var _wordDirept3:FilterFrameText;
      
      private var _wordDirept4:FilterFrameText;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _daojishiTxt:Bitmap;
      
      public function FirstTouchView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function initView() : void
      {
         var j:int = 0;
         var gItem:* = null;
         var pic:* = null;
         var length:int = 0;
         var mc:* = null;
         var mc1:* = null;
         _goodsContentList = new Vector.<BagCell>();
         _treeImage = ComponentFactory.Instance.creatComponentByStylename("fristRecharge.scale9cornerImageTree");
         addToContent(_treeImage);
         _treeImage2 = ComponentFactory.Instance.creatComponentByStylename("accumulationView.rightBottomBgImg");
         addToContent(_treeImage2);
         _back = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.SignedAwardBack");
         addToContent(_back);
         _wordDirept = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept.text = "Gunner thân mến:\nBạn chưa nạp thẻ trong thời gian hoạt động. ";
         addToContent(_wordDirept);
         _wordDirept2 = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept2.text = LanguageMgr.GetTranslation("firstTouchView.wordDirept2");
         PositionUtils.setPos(_wordDirept2,"firstRecharge.wordDireptText2Pos");
         addToContent(_wordDirept2);
         _rechargeGiftBagValueText1 = ComponentFactory.Instance.creatComponentByStylename("fristRecharge.rechargeMoneyTotalText1");
         addToContent(_rechargeGiftBagValueText1);
         _rechargeGiftBagValueText1.x = _wordDirept2.x + _wordDirept2.width;
         _rechargeGiftBagValueText1.y = _wordDirept2.y - 3;
         _rechargeGiftBagValueText1.text = FirstRechargeManger.Instance.rechargeMoneyTotal + " xu";
         _wordDirept3 = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept3.text = LanguageMgr.GetTranslation("firstTouchView.wordDirept3");
         _wordDirept3.x = _rechargeGiftBagValueText1.x + _rechargeGiftBagValueText1.width;
         _wordDirept3.y = _rechargeGiftBagValueText1.y + 3;
         addToContent(_wordDirept3);
         _wordDirept4 = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept4.text = LanguageMgr.GetTranslation("firstTouchView.wordDirept4");
         PositionUtils.setPos(_wordDirept4,"firstRecharge.wordDireptText2Pos4");
         addToContent(_wordDirept4);
         _rechargeMoneyTotalText = ComponentFactory.Instance.creatComponentByStylename("fristRecharge.rechargeMoneyTotalText");
         addToContent(_rechargeMoneyTotalText);
         PositionUtils.setPos(_rechargeMoneyTotalText,"firstRecharge.wordDireptText2Pos3");
         _rechargeMoneyTotalText.text = LanguageMgr.GetTranslation("firstTouchView.rechargeMoneyTotalText");
         _worldtitle = ComponentFactory.Instance.creatBitmap("fristRecharge.libao.title");
         addToContent(_worldtitle);
         titleText = LanguageMgr.GetTranslation("ddt.firstIntimateContact");
         _cartoonList = new Vector.<MovieClip>(2);
         var count:int = 0;
         for(j = 0; j < 7; )
         {
            gItem = new BagCell(j);
            pic = ComponentFactory.Instance.creatComponentByStylename("recharge.ItemBg");
            pic.x = j * (gItem.width + 8) + 60;
            pic.y = 254;
            gItem.x = pic.x + 2;
            gItem.y = pic.y + 2;
            addToContent(pic);
            addToContent(gItem);
            gItem.setBgVisible(false);
            _goodsContentList.push(gItem);
            length = FirstRechargeManger.Instance.getGoodsList_haiwai().length;
            if(length > 1)
            {
               if(j == 0 || j == 1)
               {
                  mc = ComponentFactory.Instance.creat("firstRecharge.cartoon");
                  mc.mouseChildren = false;
                  mc.mouseEnabled = false;
                  mc.x = pic.x - 21;
                  mc.y = pic.y - 36;
                  addToContent(mc);
                  _cartoonList[j] = mc;
               }
            }
            else if(j == 0)
            {
               mc1 = ComponentFactory.Instance.creat("firstRecharge.cartoon");
               mc1.mouseChildren = false;
               mc1.mouseEnabled = false;
               mc1.x = pic.x - 21;
               mc1.y = pic.y - 36;
               addToContent(mc1);
               _cartoonList[j] = mc1;
            }
            j++;
         }
         _child = ComponentFactory.Instance.creatBitmap("fristRecharge.child");
         addToContent(_child);
         _btn = ComponentFactory.Instance.creatComponentByStylename("accumulationView.ftxtBtn");
         addToContent(_btn);
         _btn.addEventListener("click",clickHander);
         _endTimeTxt = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.timePlayTxt");
         addToContent(_endTimeTxt);
         _daojishiTxt = ComponentFactory.Instance.creatBitmap("fristRecharge.downtimes");
         addToContent(_daojishiTxt);
         refreshTimePlayTxt();
      }
      
      public function setGoodsList(list:Vector.<RechargeData>) : void
      {
         var i:int = 0;
         var len:int = list.length;
         var count:int = 0;
         for(i = 0; i < len; )
         {
            if(count >= 7)
            {
               return;
            }
            if(list[i] && list[i].RewardID < 2000)
            {
               _goodsContentList[i].info = FirstRechargeControl.Instance.setGoods(list[i]);
               _goodsContentList[i].setCount(list[i].RewardItemCount);
            }
            count++;
            i++;
         }
      }
      
      protected function clickHander(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         LeavePageManager.leaveToFillPath();
      }
      
      private function changeStringToDate(string:String) : Date
      {
         var array:* = null;
         var firstPart:* = null;
         var secondPart:* = null;
         var date:* = null;
         if(string == "" || string == null)
         {
            return null;
         }
         array = string.split(" ");
         firstPart = array[0].split("-");
         secondPart = array[1].split(":");
         date = new Date(firstPart[0],firstPart[1] - 1,firstPart[2],secondPart[0],secondPart[1],secondPart[2]);
         return date;
      }
      
      private function refreshTimePlayTxt() : void
      {
         var timeTxtStr:* = null;
         var str:String = FirstRechargeManger.Instance.rechargeEndTime;
         var date:Date = changeStringToDate(str);
         var endTimestamp:Number = date.getTime();
         var nowdate:Date = TimeManager.Instance.Now();
         var nowTimestamp:Number = nowdate.getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         differ = differ < 0?0:Number(differ);
         var count:int = 0;
         if(differ / 86400000 > 1)
         {
            count = differ / 86400000;
            timeTxtStr = count + LanguageMgr.GetTranslation("day");
         }
         else if(differ / 3600000 > 1)
         {
            count = differ / 3600000;
            timeTxtStr = count + LanguageMgr.GetTranslation("hour");
         }
         else if(differ / 60000 > 1)
         {
            count = differ / 60000;
            timeTxtStr = count + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            count = differ / 1000;
            timeTxtStr = count + LanguageMgr.GetTranslation("second");
         }
         _endTimeTxt.text = LanguageMgr.GetTranslation("newChickenBox1.timePlayTxt",timeTxtStr);
         if(count <= 0)
         {
            _endTimeTxt.text = LanguageMgr.GetTranslation("firstTouchView.endTimeTxt");
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_response);
         if(_btn)
         {
            _btn.removeEventListener("click",clickHander);
         }
         var _loc3_:int = 0;
         var _loc2_:* = _cartoonList;
         for each(var mc in _cartoonList)
         {
            if(mc)
            {
               mc.gotoAndStop(1);
            }
         }
         _cartoonList = null;
         super.dispose();
      }
   }
}
