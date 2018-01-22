package uiModeManager.bombUI.model.rank
{
   import road7th.data.DictionaryData;
   
   public class RankRewardCfg
   {
       
      
      private var _aviliable:Boolean;
      
      private var _cfg:DictionaryData;
      
      public function RankRewardCfg()
      {
         super();
      }
      
      public function get cfg() : DictionaryData
      {
         return _cfg;
      }
      
      public function set cfg(param1:DictionaryData) : void
      {
         if(param1)
         {
            this._cfg = param1;
            this._aviliable = true;
         }
      }
      
      public function get aviliable() : Boolean
      {
         return _aviliable;
      }
   }
}
