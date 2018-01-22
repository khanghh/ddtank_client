package ddt.data.analyze
{
   import chickActivation.data.ChickActivationInfo;
   import cloudBuyLottery.data.HappyBuyBuyBuyInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PyramidSystemItemsInfo;
   import ddtmatch.data.DDTMatchFightKingInfo;
   import defendisland.data.DefendislandRewardInfo;
   import growthPackage.data.GrowthPackageInfo;
   import guildMemberWeek.data.GuildMemberWeekItemsInfo;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   import horseRace.data.HorseRaceInfo;
   import kingDivision.data.KingDivisionGoodsInfo;
   import loginDevice.LoginDeviceRewardInfo;
   import lotteryTicket.data.LotteryRewardInfo;
   import newYearRice.data.NewYearRiceInfo;
   import redEnvelope.data.RedEnvelopeInfo;
   import signBuff.data.SignBuffInfo;
   import welfareCenter.callBackFund.CallBackFundRewardInfo;
   import witchBlessing.data.WitchBlessingPackageInfo;
   
   public class ActivitySystemItemsDataAnalyzer extends DataAnalyzer
   {
       
      
      public var pyramidSystemDataList:Array;
      
      public var guildMemberWeekDataList:Array;
      
      public var growthPackageDataList:Array;
      
      public var kingDivisionDataList:Array;
      
      public var chickActivationDataList:Array;
      
      public var witchBlessingDataList:Array;
      
      public var newYearRiceDataList:Array;
      
      public var horseRaceDataList:Array;
      
      public var happyBuyBbyBuyDataList:Array;
      
      public var fightKingDataList:Array;
      
      public var redEnvelopeDataList:Array;
      
      public var loginDeviceDataList:Array;
      
      public var callbackDataList:Array;
      
      public var signBuffDataList:Array;
      
      public var lotteryDataList:Array;
      
      public var defendislandDataList:Array;
      
      public function ActivitySystemItemsDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc13_:int = 0;
         var _loc9_:* = null;
         var _loc29_:* = null;
         var _loc10_:* = null;
         var _loc26_:* = null;
         var _loc7_:* = null;
         var _loc25_:* = undefined;
         var _loc8_:* = null;
         var _loc23_:* = null;
         var _loc5_:* = null;
         var _loc36_:* = null;
         var _loc6_:* = null;
         var _loc34_:* = null;
         var _loc3_:* = null;
         var _loc32_:* = null;
         var _loc4_:* = null;
         var _loc31_:* = null;
         var _loc12_:* = null;
         var _loc17_:* = null;
         var _loc21_:* = null;
         var _loc27_:* = null;
         var _loc20_:* = null;
         var _loc28_:* = null;
         var _loc19_:* = null;
         var _loc22_:* = null;
         var _loc18_:* = null;
         var _loc24_:* = null;
         var _loc16_:* = null;
         var _loc33_:* = null;
         var _loc15_:* = null;
         var _loc35_:* = null;
         var _loc14_:* = null;
         var _loc30_:* = null;
         pyramidSystemDataList = [];
         guildMemberWeekDataList = [];
         growthPackageDataList = [];
         kingDivisionDataList = [];
         chickActivationDataList = [];
         witchBlessingDataList = [];
         newYearRiceDataList = [];
         horseRaceDataList = [];
         happyBuyBbyBuyDataList = [];
         fightKingDataList = [];
         redEnvelopeDataList = [];
         loginDeviceDataList = [];
         callbackDataList = [];
         signBuffDataList = [];
         lotteryDataList = [];
         defendislandDataList = [];
         var _loc11_:XML = new XML(param1);
         if(_loc11_.@value == "true")
         {
            _loc2_ = _loc11_..Item;
            _loc13_ = 0;
            while(_loc13_ < _loc2_.length())
            {
               if(_loc2_[_loc13_].@ActivityType == "8")
               {
                  _loc9_ = new PyramidSystemItemsInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc9_,_loc2_[_loc13_]);
                  _loc29_ = pyramidSystemDataList[_loc9_.Quality - 1];
                  if(!_loc29_)
                  {
                     _loc29_ = [];
                  }
                  _loc29_.push(_loc9_);
                  pyramidSystemDataList[_loc9_.Quality - 1] = _loc29_;
               }
               else if(_loc2_[_loc13_].@ActivityType == String(GuildMemberWeekManager.instance.getGiftType))
               {
                  _loc10_ = new GuildMemberWeekItemsInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc10_,_loc2_[_loc13_]);
                  _loc26_ = guildMemberWeekDataList[_loc10_.Quality - 1];
                  if(!_loc26_)
                  {
                     _loc26_ = [];
                  }
                  _loc26_.push(_loc10_);
                  guildMemberWeekDataList[_loc10_.Quality - 1] = _loc26_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "20")
               {
                  _loc7_ = new GrowthPackageInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc7_,_loc2_[_loc13_]);
                  _loc25_ = growthPackageDataList[_loc7_.Quality];
                  if(!_loc25_)
                  {
                     _loc25_ = new Vector.<GrowthPackageInfo>();
                  }
                  _loc25_.push(_loc7_);
                  growthPackageDataList[_loc7_.Quality] = _loc25_;
               }
               if(_loc2_[_loc13_].@ActivityType == "30")
               {
                  _loc8_ = new KingDivisionGoodsInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc8_,_loc2_[_loc13_]);
                  _loc23_ = kingDivisionDataList[_loc8_.Quality - 1];
                  if(!_loc23_)
                  {
                     _loc23_ = [];
                  }
                  _loc23_.push(_loc8_);
                  kingDivisionDataList[_loc8_.Quality - 1] = _loc23_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "40")
               {
                  _loc5_ = new ChickActivationInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc5_,_loc2_[_loc13_]);
                  if(_loc5_.Quality >= 10001 && _loc5_.Quality <= 10012)
                  {
                     _loc36_ = chickActivationDataList[12];
                     if(!_loc36_)
                     {
                        _loc36_ = [];
                     }
                     _loc36_.push(_loc5_);
                     _loc36_.sortOn("Quality",16);
                     chickActivationDataList[12] = _loc36_;
                  }
                  else
                  {
                     _loc36_ = chickActivationDataList[_loc5_.Quality];
                     if(!_loc36_)
                     {
                        _loc36_ = [];
                     }
                     _loc36_.push(_loc5_);
                     chickActivationDataList[_loc5_.Quality] = _loc36_;
                  }
               }
               else if(_loc2_[_loc13_].@ActivityType == "49")
               {
                  _loc6_ = new WitchBlessingPackageInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc6_,_loc2_[_loc13_]);
                  if(!_loc34_)
                  {
                     _loc34_ = [];
                  }
                  _loc34_.push(_loc6_);
                  witchBlessingDataList = _loc34_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "99")
               {
                  _loc3_ = new NewYearRiceInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc13_]);
                  if(!_loc32_)
                  {
                     _loc32_ = [];
                  }
                  _loc32_.push(_loc3_);
                  newYearRiceDataList = _loc32_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "60")
               {
                  _loc4_ = new HorseRaceInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc4_,_loc2_[_loc13_]);
                  if(!_loc31_)
                  {
                     _loc31_ = [];
                  }
                  _loc31_.push(_loc4_);
                  horseRaceDataList = _loc31_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "100")
               {
                  _loc12_ = new HappyBuyBuyBuyInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc12_,_loc2_[_loc13_]);
                  if(!_loc17_)
                  {
                     _loc17_ = [];
                  }
                  _loc17_.push(_loc12_);
                  happyBuyBbyBuyDataList = _loc17_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "62")
               {
                  _loc21_ = new DDTMatchFightKingInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc21_,_loc2_[_loc13_]);
                  if(!_loc27_)
                  {
                     _loc27_ = [];
                  }
                  _loc27_.push(_loc21_);
                  fightKingDataList = _loc27_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "108")
               {
                  _loc20_ = new RedEnvelopeInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc20_,_loc2_[_loc13_]);
                  if(!_loc28_)
                  {
                     _loc28_ = [];
                  }
                  _loc28_.push(_loc20_);
                  redEnvelopeDataList = _loc28_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "110")
               {
                  _loc19_ = new LoginDeviceRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc19_,_loc2_[_loc13_]);
                  if(!_loc22_)
                  {
                     _loc22_ = [];
                  }
                  _loc22_.push(_loc19_);
                  loginDeviceDataList = _loc22_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "111")
               {
                  _loc18_ = new CallBackFundRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc18_,_loc2_[_loc13_]);
                  if(!_loc24_)
                  {
                     _loc24_ = [];
                  }
                  _loc24_.push(_loc18_);
                  callbackDataList = _loc24_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "112")
               {
                  _loc16_ = new SignBuffInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc16_,_loc2_[_loc13_]);
                  if(!_loc33_)
                  {
                     _loc33_ = [];
                  }
                  _loc33_.push(_loc16_);
                  signBuffDataList = _loc33_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "114")
               {
                  _loc15_ = new LotteryRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc15_,_loc2_[_loc13_]);
                  if(!_loc35_)
                  {
                     _loc35_ = [];
                  }
                  _loc35_.push(_loc15_);
                  lotteryDataList = _loc35_;
               }
               else if(_loc2_[_loc13_].@ActivityType == "155")
               {
                  _loc14_ = new DefendislandRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc14_,_loc2_[_loc13_]);
                  if(!_loc30_)
                  {
                     _loc30_ = [];
                  }
                  _loc30_.push(_loc14_);
                  defendislandDataList = _loc30_;
               }
               _loc13_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc11_.@message;
            onAnalyzeError();
         }
      }
   }
}
