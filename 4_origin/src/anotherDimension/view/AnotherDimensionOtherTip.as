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
      
      public function AnotherDimensionOtherTip(param1:AnotherDimensionResourceInfo)
      {
         super();
         _info = param1;
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
         var _loc3_:int = param1.itemId;
         var _loc2_:String = ItemManager.Instance.getTemplateById(_loc3_).Name;
         _chanchuText.text = _loc2_;
         _chanliangText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.chanliangText");
         addChild(_chanliangText);
         _chanliangText.text = LanguageMgr.GetTranslation("anotherDimension.itemCountTxt",param1.itemCountPerHour);
         _canLueduoText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.canLueduoText");
         addChild(_canLueduoText);
         _haveItemText = ComponentFactory.Instance.creatComponentByStylename("anotherDimension.anotherDimensionOtherItemTip.haveItemText");
         addChild(_haveItemText);
         _haveItemText.visible = false;
      }
      
      public function setSelfTipStyle(param1:AnotherDimensionResourceInfo) : void
      {
         _bg.height = 150;
         _line2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line2.width = 190;
         _line2.x = 4;
         _line2.y = 116;
         addChild(_line2);
         _haveItemText.visible = true;
         var _loc2_:int = getItemCountByTime2(param1);
         _haveItemText.text = LanguageMgr.GetTranslation("anotherDimensionitemCountTxt.alreadGetTxt",_loc2_);
      }
      
      private function getItemCountByTime(param1:AnotherDimensionResourceInfo) : int
      {
         var _loc9_:Date = param1.haveResourceTime;
         if(_loc9_ == null)
         {
            return 0;
         }
         var _loc8_:Date = TimeManager.Instance.Now();
         var _loc3_:Number = _loc9_.getTime();
         var _loc2_:Number = _loc8_.getTime();
         var _loc7_:Number = _loc2_ - _loc3_;
         var _loc5_:int = Math.floor(_loc7_ / minuteTime);
         if(_loc5_ >= param1.lastMaxMunites)
         {
            _loc5_ = param1.lastMaxMunites;
         }
         var _loc4_:int = Math.floor(param1.itemCountPerHour * _loc5_ / 120);
         var _loc6_:int = Math.floor(_loc4_ / 3);
         if(_loc6_ <= 0)
         {
            _loc6_ = 1;
         }
         return _loc6_;
      }
      
      private function getItemCountByTime2(param1:AnotherDimensionResourceInfo) : int
      {
         var _loc8_:Date = param1.haveResourceTime;
         if(_loc8_ == null)
         {
            return 0;
         }
         var _loc7_:Date = TimeManager.Instance.Now();
         var _loc3_:Number = _loc8_.getTime();
         var _loc2_:Number = _loc7_.getTime();
         var _loc6_:Number = _loc2_ - _loc3_;
         var _loc5_:int = Math.floor(_loc6_ / minuteTime);
         if(_loc5_ >= param1.lastMaxMunites)
         {
            _loc5_ = param1.lastMaxMunites;
         }
         var _loc4_:int = Math.floor(param1.itemCountPerHour * _loc5_ / 120);
         if(_loc4_ <= 0)
         {
            _loc4_ = 1;
         }
         return _loc4_;
      }
      
      public function refreshView(param1:AnotherDimensionResourceInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1.monsterId == 0)
         {
            _titleTxt.text = param1.resourcePlayerInfo.NickName;
            _canLueduoTitleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.canlueduotxt");
            _canLueduoText.htmlText = getItemCountByTime(param1) + LanguageMgr.GetTranslation("anotherDimensionitemCountTxt.txt");
         }
         else
         {
            _canLueduoTitleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.canzhanlingtxt");
            _loc3_ = param1.haveResourceLast / 60;
            if(_loc3_ == 0)
            {
               _loc3_ = 2;
            }
            if(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv == 0)
            {
               _loc2_ = 0;
            }
            else
            {
               _loc2_ = getTimeControlExpBylv(AnotherDimensionManager.Instance.anotherDimensionInfo.timeControlLv)[2];
            }
            _canLueduoText.htmlText = LanguageMgr.GetTranslation("anotherDimensionitemCountTxt.hourtxt",_loc3_,_loc2_);
            if(param1.resourceLevel == 1)
            {
               _titleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.downLevel");
            }
            else if(param1.resourceLevel == 2)
            {
               _titleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.middleLevel");
            }
            else if(param1.resourceLevel == 3)
            {
               _titleTxt.text = LanguageMgr.GetTranslation("anotherDimension.anotherDimensionOtherItemTip.topLevel");
            }
         }
      }
      
      private function getTimeControlExpBylv(param1:int) : Array
      {
         var _loc2_:Array = ServerConfigManager.instance.getTimeControl();
         var _loc4_:String = _loc2_[param1 - 1];
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_;
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
