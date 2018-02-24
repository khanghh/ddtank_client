package hallIcon
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import firstRecharge.FirstRechargeManger;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hallIcon.event.HallIconEvent;
   import hallIcon.info.HallIconInfo;
   import hallIcon.model.HallIconModel;
   import kingBless.KingBlessManager;
   import worldboss.WorldBossManager;
   
   public class HallIconManager extends EventDispatcher
   {
      
      public static var ISLEAGUE:Boolean;
      
      private static var _instance:HallIconManager;
       
      
      public var model:HallIconModel;
      
      public function HallIconManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : HallIconManager
      {
         if(_instance == null)
         {
            _instance = new HallIconManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         model = new HallIconModel();
         initEvent();
      }
      
      public function checkDefaultIconShow() : void
      {
         model.expblessedIsOpen = true;
         if(PlayerManager.Instance.Self.Grade < 30 && !PlayerManager.Instance.Self.IsVIP)
         {
            model.vipLvlIsOpen = true;
         }
         if(KingBlessManager.instance.openType == 0 && PlayerManager.Instance.Self.Grade < 30)
         {
            model.kingBlessIsOpen = true;
         }
         model.wonderFulPlayIsOpen = true;
         model.activityIsOpen = true;
         model.everyDayActivityIsOpen = true;
         model.firstRechargeIsOpen = FirstRechargeManger.Instance.isOpen;
      }
      
      public function checkIconCall() : void
      {
         FirstRechargeManger.Instance.openFun = firstRechargeOpenHandler;
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.addEventListener("VIPStateChange",__vipLvlIsOpenHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onPlayerPropertyChange);
      }
      
      private function firstRechargeOpenHandler() : void
      {
         model.firstRechargeIsOpen = FirstRechargeManger.Instance.isOpen;
         model.dataChange("updateLeftIconView",new HallIconInfo("firstrecharge"));
      }
      
      private function __vipLvlIsOpenHandler(param1:Event) : void
      {
         if(PlayerManager.Instance.Self.Grade < 30 && !PlayerManager.Instance.Self.IsVIP)
         {
            model.vipLvlIsOpen = true;
         }
         else
         {
            model.vipLvlIsOpen = false;
         }
         model.dataChange("updateLeftIconView",new HallIconInfo("viplvl"));
      }
      
      private function cacheRightIcon(param1:String, param2:HallIconInfo) : void
      {
         if(param2.isopen)
         {
            model.cacheRightIconDic[param1] = param2;
         }
         else if(model.cacheRightIconDic[param1])
         {
            delete model.cacheRightIconDic[param1];
         }
      }
      
      public function checkCacheRightIconShow() : void
      {
         model.dispatchEvent(new HallIconEvent("updateBatchRightIconView"));
      }
      
      public function executeCacheRightIconLevelLimit(param1:String, param2:Boolean, param3:int = 0) : void
      {
         if(param2)
         {
            model.cacheRightIconLevelLimit[param1] = param3;
         }
         else if(model.cacheRightIconLevelLimit[param1])
         {
            delete model.cacheRightIconLevelLimit[param1];
         }
      }
      
      private function __onPlayerPropertyChange(param1:PlayerPropertyEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade)
         {
            var _loc5_:int = 0;
            var _loc4_:* = model.cacheRightIconLevelLimit;
            for(var _loc3_ in model.cacheRightIconLevelLimit)
            {
               _loc2_ = model.cacheRightIconLevelLimit[_loc3_];
               if(PlayerManager.Instance.Self.Grade >= _loc2_)
               {
                  updateSwitchHandler(_loc3_,true);
                  delete model.cacheRightIconLevelLimit[_loc3_];
               }
            }
         }
      }
      
      public function updateSwitchHandler(param1:String, param2:Boolean, param3:String = null, param4:int = -1, param5:Boolean = false) : void
      {
         var _loc6_:HallIconInfo = convertIconInfo(param1,param2,param3,param4,param5);
         cacheRightIcon(param1,_loc6_);
         model.dispatchEvent(new HallIconEvent("updateRightIconView",_loc6_));
      }
      
      private function convertIconInfo(param1:String, param2:Boolean, param3:String, param4:int, param5:Boolean) : HallIconInfo
      {
         var _loc6_:Boolean = false;
         var _loc8_:int = 0;
         var _loc7_:int = 99;
         var _loc10_:* = param1;
         if("worldbossentrance1" !== _loc10_)
         {
            if("worldbossentrance4" !== _loc10_)
            {
               if("ringstation" !== _loc10_)
               {
                  if("league" !== _loc10_)
                  {
                     if("trial" !== _loc10_)
                     {
                        if("transnational" !== _loc10_)
                        {
                           if("consortiabattle" !== _loc10_)
                           {
                              if("camp" !== _loc10_)
                              {
                                 if("fightfootballtime" !== _loc10_)
                                 {
                                    if("sevendouble" !== _loc10_)
                                    {
                                       if("littlegamenote" !== _loc10_)
                                       {
                                          if("flowerGiving" !== _loc10_)
                                          {
                                             if("escort" !== _loc10_)
                                             {
                                                if("buried" !== _loc10_)
                                                {
                                                   if("moneyTree" !== _loc10_)
                                                   {
                                                      if("draft" !== _loc10_)
                                                      {
                                                         if("PolarFuzion" !== _loc10_)
                                                         {
                                                            if("survival" !== _loc10_)
                                                            {
                                                               if("accumulativeLogin" !== _loc10_)
                                                               {
                                                                  if("sevenDayTarget" !== _loc10_)
                                                                  {
                                                                     if("godsRoads" !== _loc10_)
                                                                     {
                                                                        if("limitActivity" !== _loc10_)
                                                                        {
                                                                           if("oldPlayerRegress" !== _loc10_)
                                                                           {
                                                                              if("growthPackage" !== _loc10_)
                                                                              {
                                                                                 if("leftGunRoulette" !== _loc10_)
                                                                                 {
                                                                                    if("groupPurchase" !== _loc10_)
                                                                                    {
                                                                                       if("newChickenBox" !== _loc10_)
                                                                                       {
                                                                                          if("superWinner" !== _loc10_)
                                                                                          {
                                                                                             if("luckStar" !== _loc10_)
                                                                                             {
                                                                                                if("dice" !== _loc10_)
                                                                                                {
                                                                                                   if("treasureHunting" !== _loc10_)
                                                                                                   {
                                                                                                      if("guildMemberWeek" !== _loc10_)
                                                                                                      {
                                                                                                         if("pyramid" !== _loc10_)
                                                                                                         {
                                                                                                            if("syah" !== _loc10_)
                                                                                                            {
                                                                                                               if("mysteriousRoulette" !== _loc10_)
                                                                                                               {
                                                                                                                  if("catchBeast" !== _loc10_)
                                                                                                                  {
                                                                                                                     if("lanternRiddles" !== _loc10_)
                                                                                                                     {
                                                                                                                        if("christmas" !== _loc10_)
                                                                                                                        {
                                                                                                                           if("luckStone" !== _loc10_)
                                                                                                                           {
                                                                                                                              if("lightRoad" !== _loc10_)
                                                                                                                              {
                                                                                                                                 if("entertainment" !== _loc10_)
                                                                                                                                 {
                                                                                                                                    if("saleshop" !== _loc10_)
                                                                                                                                    {
                                                                                                                                       if("kingDivision" !== _loc10_)
                                                                                                                                       {
                                                                                                                                          if("chickActivation" !== _loc10_)
                                                                                                                                          {
                                                                                                                                             if("DDPlay" !== _loc10_)
                                                                                                                                             {
                                                                                                                                                if("boguadventure" !== _loc10_)
                                                                                                                                                {
                                                                                                                                                   if("halloween" !== _loc10_)
                                                                                                                                                   {
                                                                                                                                                      if("witchblessing" !== _loc10_)
                                                                                                                                                      {
                                                                                                                                                         if("treasurepuzzle" !== _loc10_)
                                                                                                                                                         {
                                                                                                                                                            if("worshipTheMoon" !== _loc10_)
                                                                                                                                                            {
                                                                                                                                                               if("FoodActivity" !== _loc10_)
                                                                                                                                                               {
                                                                                                                                                                  if("rescue" !== _loc10_)
                                                                                                                                                                  {
                                                                                                                                                                     if("catchinsect" !== _loc10_)
                                                                                                                                                                     {
                                                                                                                                                                        if("magpiebridge" !== _loc10_)
                                                                                                                                                                        {
                                                                                                                                                                           if("cloudbuylottery" !== _loc10_)
                                                                                                                                                                           {
                                                                                                                                                                              if("treasurelost" !== _loc10_)
                                                                                                                                                                              {
                                                                                                                                                                                 if("newYearRice" !== _loc10_)
                                                                                                                                                                                 {
                                                                                                                                                                                    if("zodiac" !== _loc10_)
                                                                                                                                                                                    {
                                                                                                                                                                                       if("horseRace" !== _loc10_)
                                                                                                                                                                                       {
                                                                                                                                                                                          if("petIsland" !== _loc10_)
                                                                                                                                                                                          {
                                                                                                                                                                                             if("prayIndiana" !== _loc10_)
                                                                                                                                                                                             {
                                                                                                                                                                                                if("happyRecharge" !== _loc10_)
                                                                                                                                                                                                {
                                                                                                                                                                                                   if("ddtMatch" !== _loc10_)
                                                                                                                                                                                                   {
                                                                                                                                                                                                      if("memoryGame" !== _loc10_)
                                                                                                                                                                                                      {
                                                                                                                                                                                                         if("sanxiao" !== _loc10_)
                                                                                                                                                                                                         {
                                                                                                                                                                                                            if("panicBuying" !== _loc10_)
                                                                                                                                                                                                            {
                                                                                                                                                                                                               if("godCard" !== _loc10_)
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  if("ExchangeAct" !== _loc10_)
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     if("godOfWealth" !== _loc10_)
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        if("redEnvelope" !== _loc10_)
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           if("ddqiyuan" !== _loc10_)
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              if("welfareCenter" !== _loc10_)
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 if("luckLotteryDraw" !== _loc10_)
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    if("angelInvestment" !== _loc10_)
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       if("bombTurnTable" !== _loc10_)
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          if("signActivity" !== _loc10_)
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             if("bravedoor" !== _loc10_)
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                if("lotteryTicket" !== _loc10_)
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   if("goldmine" !== _loc10_)
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      if("cityBattle" !== _loc10_)
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         if("oldPlayerComeBack" !== _loc10_)
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            if("ddtKingWay" !== _loc10_)
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               if("indiana" !== _loc10_)
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  if("sevenday" !== _loc10_)
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     if("condiscount" !== _loc10_)
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        if("defend_island" !== _loc10_)
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           if("conRecharge" !== _loc10_)
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              if("bank" !== _loc10_)
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 if("stock" !== _loc10_)
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    if("mines" !== _loc10_)
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       if("teamBattle" !== _loc10_)
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          if("devilTurn" === _loc10_)
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             _loc8_ = 2;
                                                                                                                                                                                                                                                                                             _loc7_ = 71;
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          _loc8_ = 1;
                                                                                                                                                                                                                                                                                          _loc7_ = 70;
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       _loc8_ = 1;
                                                                                                                                                                                                                                                                                       _loc7_ = 69;
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    _loc8_ = 2;
                                                                                                                                                                                                                                                                                    _loc7_ = 68;
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 _loc8_ = 2;
                                                                                                                                                                                                                                                                                 _loc7_ = 67;
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              _loc8_ = 2;
                                                                                                                                                                                                                                                                              _loc7_ = 66;
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           _loc8_ = 2;
                                                                                                                                                                                                                                                                           _loc7_ = 65;
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        _loc8_ = 2;
                                                                                                                                                                                                                                                                        _loc7_ = 64;
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     _loc8_ = 2;
                                                                                                                                                                                                                                                                     _loc7_ = 63;
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  _loc8_ = 2;
                                                                                                                                                                                                                                                                  _loc7_ = 62;
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               _loc8_ = 1;
                                                                                                                                                                                                                                                               _loc7_ = 61;
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            _loc8_ = 2;
                                                                                                                                                                                                                                                            _loc7_ = 60;
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         _loc8_ = 1;
                                                                                                                                                                                                                                                         _loc7_ = 59;
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      _loc8_ = 2;
                                                                                                                                                                                                                                                      _loc7_ = 58;
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   _loc8_ = 2;
                                                                                                                                                                                                                                                   _loc7_ = 57;
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                _loc8_ = 2;
                                                                                                                                                                                                                                                _loc7_ = 56;
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             _loc8_ = 2;
                                                                                                                                                                                                                                             _loc7_ = 55;
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          _loc8_ = 2;
                                                                                                                                                                                                                                          _loc7_ = 54;
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       _loc8_ = 2;
                                                                                                                                                                                                                                       _loc7_ = 53;
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    _loc6_ = false;
                                                                                                                                                                                                                                    param5 = true;
                                                                                                                                                                                                                                    _loc8_ = 2;
                                                                                                                                                                                                                                    _loc7_ = 52;
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                              else
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 _loc8_ = 2;
                                                                                                                                                                                                                                 _loc7_ = 51;
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                           else
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              _loc8_ = 2;
                                                                                                                                                                                                                              _loc7_ = 50;
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           _loc8_ = 2;
                                                                                                                                                                                                                           _loc7_ = 49;
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     else
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        _loc8_ = 2;
                                                                                                                                                                                                                        _loc7_ = 48;
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                  }
                                                                                                                                                                                                                  else
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     _loc8_ = 2;
                                                                                                                                                                                                                     _loc7_ = 47;
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  _loc8_ = 2;
                                                                                                                                                                                                                  _loc7_ = 46;
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               _loc8_ = 2;
                                                                                                                                                                                                               _loc7_ = 45;
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else
                                                                                                                                                                                                         {
                                                                                                                                                                                                            _loc8_ = 2;
                                                                                                                                                                                                            _loc7_ = 44;
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      _loc8_ = 2;
                                                                                                                                                                                                      _loc7_ = 42;
                                                                                                                                                                                                   }
                                                                                                                                                                                                   _loc8_ = 2;
                                                                                                                                                                                                   _loc7_ = 43;
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   _loc8_ = 2;
                                                                                                                                                                                                   _loc7_ = 41;
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                _loc8_ = 2;
                                                                                                                                                                                                _loc7_ = 35;
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          _loc8_ = 2;
                                                                                                                                                                                          _loc7_ = 33;
                                                                                                                                                                                       }
                                                                                                                                                                                       _loc8_ = 2;
                                                                                                                                                                                       _loc7_ = 40;
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       _loc8_ = 2;
                                                                                                                                                                                       _loc7_ = 37;
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    _loc8_ = 2;
                                                                                                                                                                                    _loc7_ = 36;
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 _loc8_ = 2;
                                                                                                                                                                                 _loc7_ = 32;
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              _loc8_ = 2;
                                                                                                                                                                              _loc7_ = 35;
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           _loc8_ = 2;
                                                                                                                                                                           _loc7_ = 34;
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        _loc8_ = 2;
                                                                                                                                                                        _loc7_ = 33;
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     _loc8_ = 2;
                                                                                                                                                                     _loc7_ = 32;
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  _loc8_ = 3;
                                                                                                                                                                  _loc7_ = 31;
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               _loc8_ = 2;
                                                                                                                                                               _loc7_ = 30;
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            _loc8_ = 2;
                                                                                                                                                            _loc7_ = 29;
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         _loc8_ = 2;
                                                                                                                                                         _loc7_ = 29;
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   _loc8_ = 2;
                                                                                                                                                   _loc7_ = 28;
                                                                                                                                                }
                                                                                                                                                _loc8_ = 2;
                                                                                                                                                _loc7_ = 29;
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                _loc8_ = 2;
                                                                                                                                                _loc7_ = 27;
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             _loc8_ = 2;
                                                                                                                                             _loc7_ = 26;
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          _loc8_ = 2;
                                                                                                                                          _loc7_ = 25;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       _loc8_ = 2;
                                                                                                                                       _loc7_ = 24;
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    _loc8_ = 2;
                                                                                                                                    _loc7_ = 23;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 _loc8_ = 2;
                                                                                                                                 _loc7_ = 22;
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc8_ = 2;
                                                                                                                              _loc7_ = 21;
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           _loc8_ = 2;
                                                                                                                           _loc7_ = 20;
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _loc8_ = 2;
                                                                                                                        _loc7_ = 19;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _loc8_ = 2;
                                                                                                                     _loc7_ = 18;
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _loc8_ = 2;
                                                                                                                  _loc7_ = 17;
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               _loc8_ = 2;
                                                                                                               _loc7_ = 16;
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            _loc8_ = 2;
                                                                                                            _loc7_ = 15;
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         _loc8_ = 2;
                                                                                                         _loc7_ = 14;
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _loc8_ = 2;
                                                                                                      _loc7_ = 13;
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   _loc8_ = 2;
                                                                                                   _loc7_ = 12;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc8_ = 2;
                                                                                                _loc7_ = 11;
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _loc8_ = 2;
                                                                                             _loc7_ = 10;
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc8_ = 2;
                                                                                          _loc7_ = 9;
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc8_ = 2;
                                                                                       _loc7_ = 8;
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc8_ = 2;
                                                                                    _loc7_ = 7;
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc8_ = 2;
                                                                                 _loc7_ = 6;
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc8_ = 2;
                                                                              _loc7_ = 5;
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc8_ = 2;
                                                                           _loc7_ = 4;
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc8_ = 2;
                                                                        _loc7_ = 3;
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc8_ = 2;
                                                                     _loc7_ = 2;
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  _loc8_ = 2;
                                                                  _loc7_ = 1;
                                                               }
                                                            }
                                                            else
                                                            {
                                                               _loc8_ = 1;
                                                               _loc7_ = 16;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc8_ = 3;
                                                            _loc7_ = 16;
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _loc8_ = 1;
                                                         _loc7_ = 17;
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc8_ = 1;
                                                      _loc7_ = 15;
                                                   }
                                                }
                                                else
                                                {
                                                   _loc8_ = 1;
                                                   _loc7_ = 14;
                                                }
                                             }
                                             else
                                             {
                                                _loc8_ = 1;
                                                _loc7_ = 13;
                                             }
                                          }
                                          else
                                          {
                                             _loc8_ = 1;
                                             _loc7_ = 12;
                                          }
                                       }
                                       else
                                       {
                                          _loc8_ = 1;
                                          _loc7_ = 11;
                                       }
                                    }
                                    else
                                    {
                                       _loc8_ = 1;
                                       _loc7_ = 10;
                                    }
                                 }
                                 else
                                 {
                                    _loc8_ = 1;
                                    _loc7_ = 9;
                                 }
                              }
                              else
                              {
                                 _loc8_ = 1;
                                 _loc7_ = 8;
                              }
                           }
                           else
                           {
                              _loc8_ = 1;
                              _loc7_ = 7;
                           }
                        }
                        else
                        {
                           _loc8_ = 1;
                           _loc7_ = 6;
                        }
                     }
                     else
                     {
                        _loc8_ = 1;
                        _loc7_ = 5;
                     }
                  }
                  else
                  {
                     _loc8_ = 1;
                     _loc7_ = 4;
                  }
               }
               else
               {
                  _loc8_ = 1;
                  _loc7_ = 3;
               }
            }
            else
            {
               _loc8_ = 1;
               if(WorldBossManager.Instance.bossInfo)
               {
                  _loc6_ = WorldBossManager.Instance.bossInfo.fightOver;
               }
               _loc7_ = 2;
            }
         }
         else
         {
            _loc8_ = 1;
            if(WorldBossManager.Instance.bossInfo)
            {
               _loc6_ = WorldBossManager.Instance.bossInfo.fightOver;
            }
            _loc7_ = 1;
         }
         var _loc9_:HallIconInfo = new HallIconInfo();
         _loc9_.halltype = _loc8_;
         _loc9_.icontype = param1;
         _loc9_.isopen = param2;
         _loc9_.timemsg = param3;
         _loc9_.fightover = _loc6_;
         _loc9_.orderid = _loc7_;
         _loc9_.num = param4;
         _loc9_.timeShow = param5;
         return _loc9_;
      }
      
      public function showCommonFrame(param1:DisplayObject, param2:String = "", param3:Number = 530, param4:Number = 545) : Frame
      {
         var _loc5_:Frame = ComponentFactory.Instance.creatCustomObject("hallIcon.commonFrame");
         _loc5_.titleText = LanguageMgr.GetTranslation(param2);
         _loc5_.width = param3;
         _loc5_.height = param4;
         _loc5_.addToContent(param1);
         _loc5_.addEventListener("response",__commonFrameResponse);
         LayerManager.Instance.addToLayer(_loc5_,3,true,1,true);
         return _loc5_;
      }
      
      private function __commonFrameResponse(param1:FrameEvent) : void
      {
         var _loc2_:Frame = param1.currentTarget as Frame;
         if(_loc2_)
         {
            _loc2_.removeEventListener("response",__commonFrameResponse);
            ObjectUtils.disposeAllChildren(_loc2_);
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
      }
      
      public function checkHallIconExperienceTask(param1:Boolean = true) : void
      {
         if(param1)
         {
            model.cacheRightIconTask = null;
         }
         else
         {
            model.cacheRightIconTask = {"isCompleted":param1};
         }
         dispatchEvent(new HallIconEvent("checkHallIconExperienceOpen"));
      }
      
      public function checkCacheRightIconTask() : void
      {
         if(model.cacheRightIconTask)
         {
            dispatchEvent(new HallIconEvent("checkHallIconExperienceOpen",model.cacheRightIconTask.isCompleted));
         }
      }
   }
}
