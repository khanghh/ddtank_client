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
         for(var j:int = 0; j <= 7; )
         {
            var item:PrivilegeViewItem = null;
            if(j == 3 || j == 4)
            {
               item = new PrivilegeViewItem(2,"asset.vip.star");
               addr73:
               item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[j]);
               if(j == 1)
               {
                  item.contentInterceptor = function(val:String):String
                  {
                     return Number(val).toFixed(1);
                  };
               }
               else if(j == 7)
               {
                  item.crossFilter = "100";
                  item.contentInterceptor = function(val:String):String
                  {
                     return (100 - val).toString();
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
               §§goto(addr73);
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
         for(j = 14; j <= 16; )
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
         var data:Vector.<String> = Vector.<String>(["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]);
         var item:PrivilegeViewItem = new PrivilegeViewItem(3);
         item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.VIPRewardTask");
         item.itemContent = data;
         _itemContainer.addChild(item);
      }
      
      private function parseVIPCryptBoss() : void
      {
         var data:Vector.<String> = ServerConfigManager.instance.VIPRewardCryptCount;
         var item:PrivilegeViewItem = new PrivilegeViewItem(3);
         item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[18]);
         item.itemContent = data;
         _itemContainer.addChild(item);
      }
      
      private function parseVipIconItem() : void
      {
         var infoArr:Array = GiveYourselfOpenView.getVipinfo();
         var item:PrivilegeViewItem = new PrivilegeViewItem(4);
         item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.VIPRwardInfo");
         item.itemContentForIcontype = infoArr;
         _itemContainer.addChild(item);
      }
      
      private function parsePrivilegeItem(privilegeNo:int, itemIndex:int) : void
      {
         var i:int = 0;
         var item:* = null;
         var data:Array = [];
         var minLevel:int = ServerConfigManager.instance.getPrivilegeMinLevel(privilegeNo.toString());
         for(i = 1; i <= 15; )
         {
            data.push(i >= minLevel?"1":"0");
            i++;
         }
         if(itemIndex == 20)
         {
            item = new PrivilegeViewItem(5);
            item.itemContent = Vector.<String>(ServerConfigManager.instance.analyzeData("VIPLevelGiftID"));
         }
         else if(itemIndex == 21)
         {
            item = new PrivilegeViewItem(5);
            item.itemContent = Vector.<String>(ServerConfigManager.instance.analyzeData("VIPSendFireRed"));
         }
         else
         {
            item = new PrivilegeViewItem(0);
            item.itemContent = Vector.<String>(data);
         }
         item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[itemIndex]);
         _itemContainer.addChild(item);
      }
      
      private function parseBenediction() : void
      {
         var i:int = 0;
         var j:* = 0;
         var maxLevel:int = 0;
         var itemIndex:int = 17;
         var data:Vector.<String> = Vector.<String>(["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]);
         for(i = 1; i <= 6; )
         {
            data[ServerConfigManager.instance.getPrivilegeMinLevel(i.toString()) - 1] = i.toString();
            i++;
         }
         maxLevel = ServerConfigManager.instance.getPrivilegeMinLevel("6");
         for(j = maxLevel; j < 15; )
         {
            data[j] = "All";
            j++;
         }
         var item:PrivilegeViewItem = new PrivilegeViewItem();
         item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem." + VIP_SETTINGS_FIELD[itemIndex]);
         item.analyzeFunction = benedictionAnalyzer;
         item.itemContent = data;
         _itemContainer.addChild(item);
      }
      
      private function benedictionAnalyzer(content:Vector.<String>) : Vector.<DisplayObject>
      {
         var txt:* = null;
         var cross:* = null;
         var result:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var startPos:Point = ComponentFactory.Instance.creatCustomObject("vip.levelPrivilegeBenedctionItemTxtStartPos");
         var _loc8_:int = 0;
         var _loc7_:* = content;
         for each(var con in content)
         {
            if(con != "0")
            {
               txt = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewBenedctionItemTxt");
               txt.text = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.MayneRand" + con);
               PositionUtils.setPos(txt,startPos);
               txt.x = txt.x + 6;
               txt.y = txt.y - 5;
               startPos.x = startPos.x + 45;
               result.push(txt);
               autoText(txt);
            }
            else
            {
               cross = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.cross");
               PositionUtils.setPos(cross,startPos);
               cross.x = startPos.x + (40 - cross.width);
               startPos.x = startPos.x + 45;
               result.push(cross);
            }
         }
         return result;
      }
      
      private function autoText(_txt:FilterFrameText) : void
      {
         var txtFormat:* = null;
         if(_txt.numLines >= 2)
         {
            _txt.width = 45;
            _txt.x = _txt.x - 8;
            txtFormat = _txt.getTextFormat();
            txtFormat.size = 8;
            _txt.setTextFormat(txtFormat);
         }
      }
      
      private function parseRingStation(privilegeNo:int) : void
      {
         var i:int = 0;
         var data:Array = [];
         var minLevel:int = ServerConfigManager.instance.getPrivilegeMinLevel(privilegeNo.toString());
         for(i = 1; i <= 15; )
         {
            data.push(i >= minLevel?"1":"0");
            i++;
         }
         var item:PrivilegeViewItem = new PrivilegeViewItem(0);
         item.itemTitleText = LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.VIPRingStation");
         item.itemContent = Vector.<String>(data);
         _itemContainer.addChild(item);
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var icon:* = null;
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
         var xPos:int = 0;
         var yPos:int = 0;
         for(i = 1; i <= 15; )
         {
            icon = ComponentFactory.Instance.creatComponentByStylename("vip.LevelPrivilegeView.VipIcon" + i);
            _titleIcons.push(icon);
            addChild(icon);
            if(i == 1)
            {
               xPos = icon.x;
               yPos = icon.y;
            }
            else
            {
               xPos = xPos + 45;
               icon.x = xPos;
               icon.y = yPos;
            }
            i++;
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
         for each(var img in _titleIcons)
         {
            ObjectUtils.disposeObject(img);
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
