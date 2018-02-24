package consumeRank.data
{
   public class ConsumeRankVo
   {
       
      
      public var userId:int;
      
      public var name:String;
      
      public var consume:int;
      
      public var vipLvl:int;
      
      public function ConsumeRankVo(){super();}
      
      public function get isVIP() : Boolean{return false;}
   }
}
