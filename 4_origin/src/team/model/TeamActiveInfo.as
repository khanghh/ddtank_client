package team.model
{
   public class TeamActiveInfo
   {
       
      
      public var Type:int;
      
      public var ChannelDesc:String;
      
      public var MaxLimit:int;
      
      public var AddScore:int;
      
      public var JumpTo:int;
      
      public var haveScore:int;
      
      public function TeamActiveInfo()
      {
         super();
      }
      
      public function get scoreProgress() : Number
      {
         return haveScore / MaxLimit;
      }
   }
}
