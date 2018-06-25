package anotherDimension.view
{
   import anotherDimension.controller.AnotherDimensionManager;
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   
   public class AnotherDimensionOtherTip extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _chanchuTitleTxt:FilterFrameText;
      
      private var _chanliangTitleTxt:FilterFrameText;
      
      private var _canLueduoTitleTxt:FilterFrameText;
      
      private var _chanchuText:FilterFrameText;
      
      private var _chanliangText:FilterFrameText;
      
      private var _canLueduoText:FilterFrameText;
      
      private var _line2:ScaleBitmapImage;
      
      private var _haveItemText:FilterFrameText;
      
      private var _info:AnotherDimensionResourceInfo;
      
      private var hourTime:Number = 3600000.0;
      
      private var minuteTime:Number = 60000.0;
      
      public function AnotherDimensionOtherTip(info:AnotherDimensionResourceInfo)
      {
         super();
         _info = info;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _bg.width = 210;
         _bg.height = 120;
         addChild(_bg);
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line.width = 190;
         _line.x = 4;
         _line.y = 36;
         addChild(_line);
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.titleText");
         addChild(_titleTxt);
         _chanchuTitleTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.chanchuTitleTxt");
         addChild(_chanchuTitleTxt);
         _chanchuTitleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.chanchuTitleTxt");
         _chanliangTitleTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.chanliangTitleTxt");
         addChild(_chanliangTitleTxt);
         _chanliangTitleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.chanliangTitleTxt");
         _canLueduoTitleTxt = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.canLueduoTitleTxt");
         addChild(_canLueduoTitleTxt);
         _chanchuText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.chanchuText");
         addChild(_chanchuText);
         var itemId:int = info.itemId;
         var itemName:String = ItemManager.Instance.getTemplateById(itemId).Name;
         _chanchuText.text = itemName;
         _chanliangText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.chanliangText");
         addChild(_chanliangText);
         _chanliangText.text = LanguageMgr.GetTranslation("anotherDimension.itemCountTxt",info.itemCountPerHour);
         _canLueduoText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.canLueduoText");
         addChild(_canLueduoText);
         _haveItemText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.haveItemText");
         addChild(_haveItemText);
         _haveItemText.visible = false;
      }
      
      public function setSelfTipStyle(data:AnotherDimensionResourceInfo) : void
      {
         _bg.height = 150;
         _line2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line2.width = 190;
         _line2.x = 4;
         _line2.y = 116;
         addChild(_line2);
         _haveItemText.visible = true;
         var count:int = getItemCountByTime2(data);
         _haveItemText.text = LanguageMgr.GetTranslation("anotherDimensionitemCountTxt.alreadGetTxt",count);
      }
      
      private function getItemCountByTime(data:AnotherDimensionResourceInfo) : int
      {
         var zhanlingTime:Date = data.haveResourceTime;
         if(zhanlingTime == null)
         {
            return 0;
         }
         var nowTime:Date = TimeManager.Instance.Now();
         var zhanlingTotal:Number = zhanlingTime.getTime();
         var nowTimeTotal:Number = nowTime.getTime();
         var between:Number = nowTimeTotal - zhanlingTotal;
         var betweenMinute:int = Math.floor(between / minuteTime);
         if(betweenMinute >= data.lastMaxMunites)
         {
            betweenMinute = data.lastMaxMunites;
         }
         var itemCount:int = Math.floor(data.itemCountPerHour * betweenMinute / 120);
         var itemCount1:int = Math.floor(itemCount / 3);
         if(itemCount1 <= 0)
         {
            itemCount1 = 1;
         }
         return itemCount1;
      }
      
      private function getItemCountByTime2(data:AnotherDimensionResourceInfo) : int
      {
         var zhanlingTime:Date = data.haveResourceTime;
         if(zhanlingTime == null)
         {
            return 0;
         }
         var nowTime:Date = TimeManager.Instance.Now();
         var zhanlingTotal:Number = zhanlingTime.getTime();
         var nowTimeTotal:Number = nowTime.getTime();
         var between:Number = nowTimeTotal - zhanlingTotal;
         var betweenMinute:int = Math.floor(between / minuteTime);
         if(betweenMinute >= data.lastMaxMunites)
         {
            betweenMinute = data.lastMaxMunites;
         }
         var itemCount:int = Math.floor(data.itemCountPerHour * betweenMinute / 120);
         if(itemCount <= 0)
         {
            itemCount = 1;
         }
         return itemCount;
      }
      
      public function refreshView(data:AnotherDimensionResourceInfo) : void
      {
         var lastTime:int = 0;
         var shijiankongzhiCount:int = 0;
         if(data.monsterId == 0)
         {
            _titleTxt.text = data.resourcePlayerInfo.NickName;
            _canLueduoTitleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.canlueduotxt");
            _canLueduoText.htmlText = getItemCountByTime(data) + LanguageMgr.GetTranslation("anotherDimensionitemCountTxt.txt");
         }
         else
         {
            _canLueduoTitleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.canzhanlingtxt");
            lastTime = data.haveResourceLast / 60;
            if(lastTime == 0)
            {
               lastTime = 2;
            }
            if(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv == 0)
            {
               shijiankongzhiCount = 0;
            }
            else
            {
               shijiankongzhiCount = getTimeControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[2];
            }
            _canLueduoText.htmlText = LanguageMgr.GetTranslation("anotherDimensionitemCountTxt.hourtxt",lastTime,shijiankongzhiCount);
            if(data.resourceLevel == 1)
            {
               _titleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.downLevel");
            }
            else if(data.resourceLevel == 2)
            {
               _titleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.middleLevel");
            }
            else if(data.resourceLevel == 3)
            {
               _titleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.topLevel");
            }
         }
      }
      
      private function getTimeControlExpBylv(lv:int) : Array
      {
         var arr:Array = ServerConfigManager.instance.getTimeControl();
         var info:String = arr[lv - 1];
         var infoArr:Array = info.split(",");
         return infoArr;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _line = null;
         _titleTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
