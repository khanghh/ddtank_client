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
      
      public function set cfg(value:DictionaryData) : void
      {
         if(value)
         {
            this._cfg = value;
            this._aviliable = true;
         }
      }
      
      public function get aviliable() : Boolean
      {
         return _aviliable;
      }
   }
}
