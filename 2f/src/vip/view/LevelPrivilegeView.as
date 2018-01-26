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
      
      public function LevelPrivilegeView(){super();}
      
      private function initItem() : void{}
      
      private function parseRewardTaskItem() : void{}
      
      private function parseVIPCryptBoss() : void{}
      
      private function parseVipIconItem() : void{}
      
      private function parsePrivilegeItem(param1:int, param2:int) : void{}
      
      private function parseBenediction() : void{}
      
      private function benedictionAnalyzer(param1:Vector.<String>) : Vector.<DisplayObject>{return null;}
      
      private function autoText(param1:FilterFrameText) : void{}
      
      private function parseRingStation(param1:int) : void{}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}
