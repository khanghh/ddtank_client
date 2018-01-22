package vip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class LevelPrivilegeView extends Sprite implements Disposeable
   {
      
      private static const MAX_LEVEL:int = 15;
      
      private static const VIP_SETTINGS_FIELD:Array = ["ShopVipScore","VIPRateForGP","VIPStrengthenEx","VIPQuestStar","VIPBruiedStar","VIPLotteryCountMaxPerDay","VIPExtraBindMoneyUpper","VIPTakeCardDisCount","VIPLotteryNoTime","VIPBossBattle","CanBuyFert","FarmAssistant","PetFifthSkill","LoginSysNotice","VIPMetalRelieve","VIPWeekly","HotSpringBathrobe","VIPBenediction","VIPCrytBoss","LoginSysNotice2","VIPGradePackage","FireworksWeekPacks"];
       
      
      private var _bg:Image;
      
      private var _titleBg:Image;
      
      private var _titleSeperators:Image;
      
      private var _titleTxt:FilterFrameText;
      
      private var _titleIcons:Vector.<Image>;
      
      private var _itemScrollPanel:ScrollPanel;
      
      private var _itemContainer:VBox;
      
      private var _seperator:Image;
      
      private var _currentVip:Image;
      
      private var _units:Dictionary;
      
      private var _minPrivilegeLevel:Dictionary;
      
      public function LevelPrivilegeView()
      {
         _minPrivilegeLevel = new Dictionary();
         super();
         _units = new Dictionary();
         _units[2] = "%";
         var _loc1_:* = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.TimesUnit");
         _units[6] = _loc1_;
         _units[5] = _loc1_;
         _units[7] = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.DiscountUnit");
         initView();
         initItem();
      }
      
      private function initItem() : void
      {
         var j:int = 0;
         while(j <= 7)
         {
            var item:PrivilegeViewItem = null;
            if(j == 3 || j == 4)
            {
               item = new PrivilegeViewItem(2,"asset.vip.star");
               addr61:
               item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[j]);
               if(j == 1)
               {
                  item.contentInterceptor = function(param1:String):String
                  {
                     return Number(param1).toFixed(1);
                  };
               }
               else if(j == 7)
               {
                  item.crossFilter = "100";
                  item.contentInterceptor = function(param1:String):String
                  {
                     return (100 - param1).toString();
                  };
               }
               if(j == 4)
               {
                  item.itemContent = Vector.<String>(ServerConfigManager.instance.analyzeData("VIPQuestStar"));
               }
               else
               {
                  item.itemContent = Vector.<String>(ServerConfigManager.instance.analyzeData(VIP_SETTINGS_FIELD[j]));
               }
               if(j != 5)
               {
                  _itemContainer.addChild(item);
               }
            }
            else if(j != 4)
            {
               if(_units[j] != null)
               {
                  item = new PrivilegeViewItem(1,_units[j]);
               }
               else
               {
                  item = new PrivilegeViewItem();
               }
               §§goto(addr61);
            }
            j = Number(j) + 1;
         }
         parsePrivilegeItem(11,9);
         parsePrivilegeItem(8,10);
         parsePrivilegeItem(10,11);
         parsePrivilegeItem(9,12);
         parsePrivilegeItem(12,13);
         parsePrivilegeItem(15,19);
         var data:Vector.<String> = Vector.<String>(["1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"]);
         j = 14;
         while(j <= 16)
         {
            var item2:PrivilegeViewItem = new PrivilegeViewItem(0);
            item2.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[j]);
            item2.itemContent = data;
            _itemContainer.addChild(item2);
            j = Number(j) + 1;
         }
         parseBenediction();
         parseVIPCryptBoss();
         parseRewardTaskItem();
         parsePrivilegeItem(12,21);
         parsePrivilegeItem(12,20);
         _itemScrollPanel.invalidateViewport();
      }
      
      private function parseRewardTaskItem() : void
      {
         var _loc2_:Vector.<String> = Vector.<String>(["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]);
         var _loc1_:PrivilegeViewItem = new PrivilegeViewItem(3);
         _loc1_.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.VIPRewardTask");
         _loc1_.itemContent = _loc2_;
         _itemContainer.addChild(_loc1_);
      }
      
      private function parseVIPCryptBoss() : void
      {
         var _loc2_:Vector.<String> = ServerConfigManager.instance.VIPRewardCryptCount;
         var _loc1_:PrivilegeViewItem = new PrivilegeViewItem(3);
         _loc1_.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[18]);
         _loc1_.itemContent = _loc2_;
         _itemContainer.addChild(_loc1_);
      }
      
      private function parseVipIconItem() : void
      {
         var _loc2_:Array = GiveYourselfOpenView.getVipinfo();
         var _loc1_:PrivilegeViewItem = new PrivilegeViewItem(4);
         _loc1_.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.VIPRwardInfo");
         _loc1_.itemContentForIcontype = _loc2_;
         _itemContainer.addChild(_loc1_);
      }
      
      private function parsePrivilegeItem(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:Array = [];
         var _loc3_:int = ServerConfigManager.instance.getPrivilegeMinLevel(param1.toString());
         _loc6_ = 1;
         while(_loc6_ <= 15)
         {
            _loc5_.push(_loc6_ >= _loc3_?"1":"0");
            _loc6_++;
         }
         if(param2 == 20)
         {
            _loc4_ = new PrivilegeViewItem(5);
            _loc4_.itemContent = Vector.<String>(ServerConfigManager.instance.analyzeData("VIPLevelGiftID"));
         }
         else if(param2 == 21)
         {
            _loc4_ = new PrivilegeViewItem(5);
            _loc4_.itemContent = Vector.<String>(ServerConfigManager.instance.analyzeData("VIPSendFireRed"));
         }
         else
         {
            _loc4_ = new PrivilegeViewItem(0);
            _loc4_.itemContent = Vector.<String>(_loc5_);
         }
         _loc4_.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[param2]);
         _itemContainer.addChild(_loc4_);
      }
      
      private function parseBenediction() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 17;
         var _loc4_:Vector.<String> = Vector.<String>(["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]);
         _loc6_ = 1;
         while(_loc6_ <= 6)
         {
            _loc4_[ServerConfigManager.instance.getPrivilegeMinLevel(_loc6_.toString()) - 1] = _loc6_.toString();
            _loc6_++;
         }
         _loc2_ = ServerConfigManager.instance.getPrivilegeMinLevel("6");
         _loc5_ = _loc2_;
         while(_loc5_ < 15)
         {
            _loc4_[_loc5_] = "All";
            _loc5_++;
         }
         var _loc3_:PrivilegeViewItem = new PrivilegeViewItem();
         _loc3_.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[_loc1_]);
         _loc3_.analyzeFunction = benedictionAnalyzer;
         _loc3_.itemContent = _loc4_;
         _itemContainer.addChild(_loc3_);
      }
      
      private function benedictionAnalyzer(param1:Vector.<String>) : Vector.<DisplayObject>
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject("vip.levelPrivilegeBenedctionItemTxtStartPos");
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc2_ != "0")
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewBenedctionItemTxt");
               _loc5_.text = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.MayneRand" + _loc2_);
               PositionUtils.setPos(_loc5_,_loc4_);
               _loc5_.x = _loc5_.x + 6;
               _loc5_.y = _loc5_.y - 5;
               _loc4_.x = _loc4_.x + 45;
               _loc3_.push(_loc5_);
               autoText(_loc5_);
            }
            else
            {
               _loc6_ = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.cross");
               PositionUtils.setPos(_loc6_,_loc4_);
               _loc6_.x = _loc4_.x + (40 - _loc6_.width);
               _loc4_.x = _loc4_.x + 45;
               _loc3_.push(_loc6_);
            }
         }
         return _loc3_;
      }
      
      private function autoText(param1:FilterFrameText) : void
      {
         var _loc2_:* = null;
         if(param1.numLines >= 2)
         {
            param1.width = 45;
            param1.x = param1.x - 8;
            _loc2_ = param1.getTextFormat();
            _loc2_.size = 8;
            param1.setTextFormat(_loc2_);
         }
      }
      
      private function parseRingStation(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Array = [];
         var _loc2_:int = ServerConfigManager.instance.getPrivilegeMinLevel(param1.toString());
         _loc5_ = 1;
         while(_loc5_ <= 15)
         {
            _loc4_.push(_loc5_ >= _loc2_?"1":"0");
            _loc5_++;
         }
         var _loc3_:PrivilegeViewItem = new PrivilegeViewItem(0);
         _loc3_.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.VIPRingStation");
         _loc3_.itemContent = Vector.<String>(_loc4_);
         _itemContainer.addChild(_loc3_);
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeViewBg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeTitleBg");
         _titleSeperators = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewTitleItemSeperators");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeView.TitleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("ddt.vip.LevelPrivilegeView.TitleTxt");
         _seperator = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeSeperator");
         _currentVip = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeView.currentVip");
         _currentVip.x = _currentVip.x + (PlayerManager.Instance.Self.VIPLevel - 1) * 45;
         _currentVip.visible = PlayerManager.Instance.Self.IsVIP;
         addChild(_bg);
         addChild(_titleBg);
         addChild(_titleSeperators);
         addChild(_titleTxt);
         addChild(_seperator);
         _titleIcons = new Vector.<Image>();
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc4_ = 1;
         while(_loc4_ <= 15)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeView.VipIcon" + _loc4_);
            _titleIcons.push(_loc1_);
            addChild(_loc1_);
            if(_loc4_ == 1)
            {
               _loc3_ = _loc1_.x;
               _loc2_ = _loc1_.y;
            }
            else
            {
               _loc3_ = _loc3_ + 45;
               _loc1_.x = _loc3_;
               _loc1_.y = _loc2_;
            }
            _loc4_++;
         }
         addChild(_currentVip);
         _itemScrollPanel = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeView.ItemScrollPanel");
         addChild(_itemScrollPanel);
         _itemContainer = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItemContainer");
         _itemScrollPanel.setView(_itemContainer);
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _titleIcons;
         for each(var _loc1_ in _titleIcons)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _titleIcons = null;
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_titleBg);
         ObjectUtils.disposeObject(_titleSeperators);
         ObjectUtils.disposeObject(_titleTxt);
         ObjectUtils.disposeObject(_itemContainer);
         ObjectUtils.disposeObject(_itemScrollPanel);
         ObjectUtils.disposeObject(_seperator);
         ObjectUtils.disposeObject(_currentVip);
         _bg = null;
         _titleBg = null;
         _titleSeperators = null;
         _titleTxt = null;
         _itemScrollPanel = null;
         _itemContainer = null;
         _seperator = null;
         _currentVip = null;
      }
   }
}
