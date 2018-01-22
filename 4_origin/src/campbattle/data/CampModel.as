package campbattle.data
{
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   
   public class CampModel
   {
       
      
      public var isOpen:Boolean;
      
      public var playerModel:DictionaryData;
      
      public var monsterList:DictionaryData;
      
      public var scoreList:Array;
      
      public var perScoreRankList:Array;
      
      public var monsterCount:int;
      
      public var isCapture:Boolean;
      
      public var captureZoneID:int;
      
      public var captureUserID:int;
      
      public var captureName:String;
      
      public var captureTeam:int;
      
      public var liveTime:int;
      
      public var myTeam:int;
      
      public var myOutPos:Point;
      
      public var isShowResurrectView:Boolean;
      
      public var myScore:int;
      
      public var doorIsOpen:Boolean;
      
      public var winCount:int;
      
      public var endTime:Date;
      
      public var isFighting:Boolean;
      
      public var monsterPosList:Array;
      
      public function CampModel()
      {
         monsterPosList = [[610,274],[1012,256],[860,264],[1122,264],[1254,266],[560,220],[604,324],[782,210],[796,334],[938,198],[1102,194],[1102,304],[1202,194],[1140,314],[914,278]];
         super();
         playerModel = new DictionaryData();
         monsterList = new DictionaryData();
      }
   }
}
