package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   
   public class CivilMemberListAnalyze extends DataAnalyzer
   {
      
      public static const PATH:String = "MarryInfoPageList.ashx";
       
      
      public var civilMemberList:Array;
      
      public var _page:int;
      
      public var _name:String;
      
      public var _sex:Boolean;
      
      public var _totalPage:int;
      
      public function CivilMemberListAnalyze(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      private function converBoolean(param1:String) : Boolean{return false;}
   }
}
