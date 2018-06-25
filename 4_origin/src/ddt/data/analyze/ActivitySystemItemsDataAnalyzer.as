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
      
      public function ActivitySystemItemsDataAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var i:int = 0;
         var itemInfo1:* = null;
         var arr1:* = null;
         var itemInfo2:* = null;
         var arr2:* = null;
         var itemInfo3:* = null;
         var arr3:* = undefined;
         var itemInfo4:* = null;
         var arr4:* = null;
         var itemInfo5:* = null;
         var arr5:* = null;
         var itemInfo6:* = null;
         var arr6:* = null;
         var itemInfo7:* = null;
         var arr7:* = null;
         var itemInfo8:* = null;
         var arr8:* = null;
         var itemInfo9:* = null;
         var arr9:* = null;
         var itemInfo10:* = null;
         var arr10:* = null;
         var itemInfo11:* = null;
         var arr11:* = null;
         var itemInfo12:* = null;
         var arr12:* = null;
         var itemInfo13:* = null;
         var arr13:* = null;
         var itemInfo14:* = null;
         var arr14:* = null;
         var itemInfo15:* = null;
         var arr15:* = null;
         var itemInfo16:* = null;
         var arr16:* = null;
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
         var xml:XML = new XML(data);
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               if(xmllist[i].@ActivityType == "8")
               {
                  itemInfo1 = new PyramidSystemItemsInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo1,xmllist[i]);
                  arr1 = pyramidSystemDataList[itemInfo1.Quality - 1];
                  if(!arr1)
                  {
                     arr1 = [];
                  }
                  arr1.push(itemInfo1);
                  pyramidSystemDataList[itemInfo1.Quality - 1] = arr1;
               }
               else if(xmllist[i].@ActivityType == String(GuildMemberWeekManager.instance.getGiftType))
               {
                  itemInfo2 = new GuildMemberWeekItemsInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo2,xmllist[i]);
                  arr2 = guildMemberWeekDataList[itemInfo2.Quality - 1];
                  if(!arr2)
                  {
                     arr2 = [];
                  }
                  arr2.push(itemInfo2);
                  guildMemberWeekDataList[itemInfo2.Quality - 1] = arr2;
               }
               else if(xmllist[i].@ActivityType == "20")
               {
                  itemInfo3 = new GrowthPackageInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo3,xmllist[i]);
                  arr3 = growthPackageDataList[itemInfo3.Quality];
                  if(!arr3)
                  {
                     arr3 = new Vector.<GrowthPackageInfo>();
                  }
                  arr3.push(itemInfo3);
                  growthPackageDataList[itemInfo3.Quality] = arr3;
               }
               if(xmllist[i].@ActivityType == "30")
               {
                  itemInfo4 = new KingDivisionGoodsInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo4,xmllist[i]);
                  arr4 = kingDivisionDataList[itemInfo4.Quality - 1];
                  if(!arr4)
                  {
                     arr4 = [];
                  }
                  arr4.push(itemInfo4);
                  kingDivisionDataList[itemInfo4.Quality - 1] = arr4;
               }
               else if(xmllist[i].@ActivityType == "40")
               {
                  itemInfo5 = new ChickActivationInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo5,xmllist[i]);
                  if(itemInfo5.Quality >= 10001 && itemInfo5.Quality <= 10012)
                  {
                     arr5 = chickActivationDataList[12];
                     if(!arr5)
                     {
                        arr5 = [];
                     }
                     arr5.push(itemInfo5);
                     arr5.sortOn("Quality",16);
                     chickActivationDataList[12] = arr5;
                  }
                  else
                  {
                     arr5 = chickActivationDataList[itemInfo5.Quality];
                     if(!arr5)
                     {
                        arr5 = [];
                     }
                     arr5.push(itemInfo5);
                     chickActivationDataList[itemInfo5.Quality] = arr5;
                  }
               }
               else if(xmllist[i].@ActivityType == "49")
               {
                  itemInfo6 = new WitchBlessingPackageInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo6,xmllist[i]);
                  if(!arr6)
                  {
                     arr6 = [];
                  }
                  arr6.push(itemInfo6);
                  witchBlessingDataList = arr6;
               }
               else if(xmllist[i].@ActivityType == "99")
               {
                  itemInfo7 = new NewYearRiceInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo7,xmllist[i]);
                  if(!arr7)
                  {
                     arr7 = [];
                  }
                  arr7.push(itemInfo7);
                  newYearRiceDataList = arr7;
               }
               else if(xmllist[i].@ActivityType == "60")
               {
                  itemInfo8 = new HorseRaceInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo8,xmllist[i]);
                  if(!arr8)
                  {
                     arr8 = [];
                  }
                  arr8.push(itemInfo8);
                  horseRaceDataList = arr8;
               }
               else if(xmllist[i].@ActivityType == "100")
               {
                  itemInfo9 = new HappyBuyBuyBuyInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo9,xmllist[i]);
                  if(!arr9)
                  {
                     arr9 = [];
                  }
                  arr9.push(itemInfo9);
                  happyBuyBbyBuyDataList = arr9;
               }
               else if(xmllist[i].@ActivityType == "62")
               {
                  itemInfo10 = new DDTMatchFightKingInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo10,xmllist[i]);
                  if(!arr10)
                  {
                     arr10 = [];
                  }
                  arr10.push(itemInfo10);
                  fightKingDataList = arr10;
               }
               else if(xmllist[i].@ActivityType == "108")
               {
                  itemInfo11 = new RedEnvelopeInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo11,xmllist[i]);
                  if(!arr11)
                  {
                     arr11 = [];
                  }
                  arr11.push(itemInfo11);
                  redEnvelopeDataList = arr11;
               }
               else if(xmllist[i].@ActivityType == "110")
               {
                  itemInfo12 = new LoginDeviceRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo12,xmllist[i]);
                  if(!arr12)
                  {
                     arr12 = [];
                  }
                  arr12.push(itemInfo12);
                  loginDeviceDataList = arr12;
               }
               else if(xmllist[i].@ActivityType == "111")
               {
                  itemInfo13 = new CallBackFundRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo13,xmllist[i]);
                  if(!arr13)
                  {
                     arr13 = [];
                  }
                  arr13.push(itemInfo13);
                  callbackDataList = arr13;
               }
               else if(xmllist[i].@ActivityType == "112")
               {
                  itemInfo14 = new SignBuffInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo14,xmllist[i]);
                  if(!arr14)
                  {
                     arr14 = [];
                  }
                  arr14.push(itemInfo14);
                  signBuffDataList = arr14;
               }
               else if(xmllist[i].@ActivityType == "114")
               {
                  itemInfo15 = new LotteryRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo15,xmllist[i]);
                  if(!arr15)
                  {
                     arr15 = [];
                  }
                  arr15.push(itemInfo15);
                  lotteryDataList = arr15;
               }
               else if(xmllist[i].@ActivityType == "155")
               {
                  itemInfo16 = new DefendislandRewardInfo();
                  ObjectUtils.copyPorpertiesByXML(itemInfo16,xmllist[i]);
                  if(!arr16)
                  {
                     arr16 = [];
                  }
                  arr16.push(itemInfo16);
                  defendislandDataList = arr16;
               }
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
   }
}
