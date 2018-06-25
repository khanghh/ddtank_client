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
      
      public function HallIconManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      private function __vipLvlIsOpenHandler(evt:Event) : void
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
      
      private function cacheRightIcon($icontype:String, $iconInfo:HallIconInfo) : void
      {
         if($iconInfo.isopen)
         {
            model.cacheRightIconDic[$icontype] = $iconInfo;
         }
         else if(model.cacheRightIconDic[$icontype])
         {
            delete model.cacheRightIconDic[$icontype];
         }
      }
      
      public function checkCacheRightIconShow() : void
      {
         model.dispatchEvent(new HallIconEvent("updateBatchRightIconView"));
      }
      
      public function executeCacheRightIconLevelLimit($icontype:String, $isCache:Boolean, $level:int = 0) : void
      {
         if($isCache)
         {
            model.cacheRightIconLevelLimit[$icontype] = $level;
         }
         else if(model.cacheRightIconLevelLimit[$icontype])
         {
            delete model.cacheRightIconLevelLimit[$icontype];
         }
      }
      
      private function __onPlayerPropertyChange(event:PlayerPropertyEvent) : void
      {
         var tempValue:int = 0;
         if(event.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade)
         {
            var _loc5_:int = 0;
            var _loc4_:* = model.cacheRightIconLevelLimit;
            for(var tempKey in model.cacheRightIconLevelLimit)
            {
               tempValue = model.cacheRightIconLevelLimit[tempKey];
               if(PlayerManager.Instance.Self.Grade >= tempValue)
               {
                  updateSwitchHandler(tempKey,true);
                  delete model.cacheRightIconLevelLimit[tempKey];
               }
            }
         }
      }
      
      public function updateSwitchHandler($icontype:String, $isopen:Boolean, $timemsg:String = null, $num:int = -1, $timeShow:Boolean = false) : void
      {
         var iconInfo:HallIconInfo = convertIconInfo($icontype,$isopen,$timemsg,$num,$timeShow);
         cacheRightIcon($icontype,iconInfo);
         model.dispatchEvent(new HallIconEvent("updateRightIconView",iconInfo));
      }
      
      private function convertIconInfo($icontype:String, $isopen:Boolean, $timemsg:String, $num:int, $timeShow:Boolean) : HallIconInfo
      {
         var fightover:Boolean = false;
         var halltype:int = 0;
         var orderid:int = 99;
         var _loc10_:* = $icontype;
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
                                                                                                                                                                                                                                                                                          if("devilTurn" !== _loc10_)
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             if("worldcupGuess" !== _loc10_)
                                                                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                                                                if("dreamLandChallenge" !== _loc10_)
                                                                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                                                                   if("oldPlayer" === _loc10_)
                                                                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                                                                      halltype = 2;
                                                                                                                                                                                                                                                                                                      orderid = 74;
                                                                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                                                                   halltype = 2;
                                                                                                                                                                                                                                                                                                   orderid = 73;
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                                                                halltype = 2;
                                                                                                                                                                                                                                                                                                orderid = 72;
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             halltype = 2;
                                                                                                                                                                                                                                                                                             orderid = 71;
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          halltype = 1;
                                                                                                                                                                                                                                                                                          orderid = 70;
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       halltype = 1;
                                                                                                                                                                                                                                                                                       orderid = 69;
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    halltype = 2;
                                                                                                                                                                                                                                                                                    orderid = 68;
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 halltype = 2;
                                                                                                                                                                                                                                                                                 orderid = 67;
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              halltype = 2;
                                                                                                                                                                                                                                                                              orderid = 66;
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           halltype = 2;
                                                                                                                                                                                                                                                                           orderid = 65;
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        halltype = 2;
                                                                                                                                                                                                                                                                        orderid = 64;
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     halltype = 2;
                                                                                                                                                                                                                                                                     orderid = 63;
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  halltype = 2;
                                                                                                                                                                                                                                                                  orderid = 62;
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               halltype = 1;
                                                                                                                                                                                                                                                               orderid = 61;
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            halltype = 2;
                                                                                                                                                                                                                                                            orderid = 60;
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         halltype = 1;
                                                                                                                                                                                                                                                         orderid = 59;
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      halltype = 2;
                                                                                                                                                                                                                                                      orderid = 58;
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   halltype = 2;
                                                                                                                                                                                                                                                   orderid = 57;
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                halltype = 2;
                                                                                                                                                                                                                                                orderid = 56;
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             halltype = 2;
                                                                                                                                                                                                                                             orderid = 55;
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          halltype = 2;
                                                                                                                                                                                                                                          orderid = 54;
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       halltype = 2;
                                                                                                                                                                                                                                       orderid = 53;
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    fightover = false;
                                                                                                                                                                                                                                    $timeShow = true;
                                                                                                                                                                                                                                    halltype = 2;
                                                                                                                                                                                                                                    orderid = 52;
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                              else
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 halltype = 2;
                                                                                                                                                                                                                                 orderid = 51;
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                           else
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              halltype = 2;
                                                                                                                                                                                                                              orderid = 50;
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           halltype = 2;
                                                                                                                                                                                                                           orderid = 49;
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     else
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        halltype = 2;
                                                                                                                                                                                                                        orderid = 48;
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                  }
                                                                                                                                                                                                                  else
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     halltype = 2;
                                                                                                                                                                                                                     orderid = 47;
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  halltype = 2;
                                                                                                                                                                                                                  orderid = 46;
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               halltype = 2;
                                                                                                                                                                                                               orderid = 45;
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else
                                                                                                                                                                                                         {
                                                                                                                                                                                                            halltype = 2;
                                                                                                                                                                                                            orderid = 44;
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      halltype = 2;
                                                                                                                                                                                                      orderid = 42;
                                                                                                                                                                                                   }
                                                                                                                                                                                                   halltype = 2;
                                                                                                                                                                                                   orderid = 43;
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   halltype = 2;
                                                                                                                                                                                                   orderid = 41;
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                halltype = 2;
                                                                                                                                                                                                orderid = 35;
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          halltype = 2;
                                                                                                                                                                                          orderid = 33;
                                                                                                                                                                                       }
                                                                                                                                                                                       halltype = 2;
                                                                                                                                                                                       orderid = 40;
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       halltype = 2;
                                                                                                                                                                                       orderid = 37;
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    halltype = 2;
                                                                                                                                                                                    orderid = 36;
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 halltype = 2;
                                                                                                                                                                                 orderid = 32;
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              halltype = 2;
                                                                                                                                                                              orderid = 35;
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           halltype = 2;
                                                                                                                                                                           orderid = 34;
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        halltype = 2;
                                                                                                                                                                        orderid = 33;
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     halltype = 2;
                                                                                                                                                                     orderid = 32;
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  halltype = 3;
                                                                                                                                                                  orderid = 31;
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               halltype = 2;
                                                                                                                                                               orderid = 30;
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            halltype = 2;
                                                                                                                                                            orderid = 29;
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         halltype = 2;
                                                                                                                                                         orderid = 29;
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   halltype = 2;
                                                                                                                                                   orderid = 28;
                                                                                                                                                }
                                                                                                                                                halltype = 2;
                                                                                                                                                orderid = 29;
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                halltype = 2;
                                                                                                                                                orderid = 27;
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             halltype = 2;
                                                                                                                                             orderid = 26;
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          halltype = 2;
                                                                                                                                          orderid = 25;
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       halltype = 2;
                                                                                                                                       orderid = 24;
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    halltype = 2;
                                                                                                                                    orderid = 23;
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 halltype = 2;
                                                                                                                                 orderid = 22;
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              halltype = 2;
                                                                                                                              orderid = 21;
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           halltype = 2;
                                                                                                                           orderid = 20;
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        halltype = 2;
                                                                                                                        orderid = 19;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     halltype = 2;
                                                                                                                     orderid = 18;
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  halltype = 2;
                                                                                                                  orderid = 17;
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               halltype = 2;
                                                                                                               orderid = 16;
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            halltype = 2;
                                                                                                            orderid = 15;
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         halltype = 2;
                                                                                                         orderid = 14;
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      halltype = 2;
                                                                                                      orderid = 13;
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   halltype = 2;
                                                                                                   orderid = 12;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                halltype = 2;
                                                                                                orderid = 11;
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             halltype = 2;
                                                                                             orderid = 10;
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          halltype = 2;
                                                                                          orderid = 9;
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       halltype = 2;
                                                                                       orderid = 8;
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    halltype = 2;
                                                                                    orderid = 7;
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 halltype = 2;
                                                                                 orderid = 6;
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              halltype = 2;
                                                                              orderid = 5;
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           halltype = 2;
                                                                           orderid = 4;
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        halltype = 2;
                                                                        orderid = 3;
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     halltype = 2;
                                                                     orderid = 2;
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  halltype = 2;
                                                                  orderid = 1;
                                                               }
                                                            }
                                                            else
                                                            {
                                                               halltype = 1;
                                                               orderid = 16;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            halltype = 3;
                                                            orderid = 16;
                                                         }
                                                      }
                                                      else
                                                      {
                                                         halltype = 1;
                                                         orderid = 17;
                                                      }
                                                   }
                                                   else
                                                   {
                                                      halltype = 1;
                                                      orderid = 15;
                                                   }
                                                }
                                                else
                                                {
                                                   halltype = 1;
                                                   orderid = 14;
                                                }
                                             }
                                             else
                                             {
                                                halltype = 1;
                                                orderid = 13;
                                             }
                                          }
                                          else
                                          {
                                             halltype = 1;
                                             orderid = 12;
                                          }
                                       }
                                       else
                                       {
                                          halltype = 1;
                                          orderid = 11;
                                       }
                                    }
                                    else
                                    {
                                       halltype = 1;
                                       orderid = 10;
                                    }
                                 }
                                 else
                                 {
                                    halltype = 1;
                                    orderid = 9;
                                 }
                              }
                              else
                              {
                                 halltype = 1;
                                 orderid = 8;
                              }
                           }
                           else
                           {
                              halltype = 1;
                              orderid = 7;
                           }
                        }
                        else
                        {
                           halltype = 1;
                           orderid = 6;
                        }
                     }
                     else
                     {
                        halltype = 1;
                        orderid = 5;
                     }
                  }
                  else
                  {
                     halltype = 1;
                     orderid = 4;
                  }
               }
               else
               {
                  halltype = 1;
                  orderid = 3;
               }
            }
            else
            {
               halltype = 1;
               if(WorldBossManager.Instance.bossInfo)
               {
                  fightover = WorldBossManager.Instance.bossInfo.fightOver;
               }
               orderid = 2;
            }
         }
         else
         {
            halltype = 1;
            if(WorldBossManager.Instance.bossInfo)
            {
               fightover = WorldBossManager.Instance.bossInfo.fightOver;
            }
            orderid = 1;
         }
         var iconInfo:HallIconInfo = new HallIconInfo();
         iconInfo.halltype = halltype;
         iconInfo.icontype = $icontype;
         iconInfo.isopen = $isopen;
         iconInfo.timemsg = $timemsg;
         iconInfo.fightover = fightover;
         iconInfo.orderid = orderid;
         iconInfo.num = $num;
         iconInfo.timeShow = $timeShow;
         return iconInfo;
      }
      
      public function showCommonFrame($content:DisplayObject, $titleLink:String = "", $width:Number = 530, $height:Number = 545) : Frame
      {
         var _frame:Frame = ComponentFactory.Instance.creatCustomObject("hallIcon.commonFrame");
         _frame.titleText = LanguageMgr.GetTranslation($titleLink);
         _frame.width = $width;
         _frame.height = $height;
         _frame.addToContent($content);
         _frame.addEventListener("response",__commonFrameResponse);
         LayerManager.Instance.addToLayer(_frame,3,true,1,true);
         return _frame;
      }
      
      private function __commonFrameResponse(evt:FrameEvent) : void
      {
         var _frame:Frame = evt.currentTarget as Frame;
         if(_frame)
         {
            _frame.removeEventListener("response",__commonFrameResponse);
            ObjectUtils.disposeAllChildren(_frame);
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
      }
      
      public function checkHallIconExperienceTask($isCompleted:Boolean = true) : void
      {
         if($isCompleted)
         {
            model.cacheRightIconTask = null;
         }
         else
         {
            model.cacheRightIconTask = {"isCompleted":$isCompleted};
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
