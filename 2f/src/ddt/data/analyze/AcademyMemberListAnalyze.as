package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   
   public class AcademyMemberListAnalyze extends DataAnalyzer
   {
       
      
      public var academyMemberList:Vector.<AcademyPlayerInfo>;
      
      public var totalPage:int;
      
      public var selfIsRegister:Boolean;
      
      public var selfDescribe:String;
      
      public var isAlter:Boolean;
      
      public var isSelfPublishEquip:Boolean;
      
      public function AcademyMemberListAnalyze(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function converBoolean(param1:String) : Boolean{return false;}
   }
}
