package carnivalActivity.view
{
   import carnivalActivity.RookieRankInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class RookieRankTipItem extends Sprite implements Disposeable
   {
       
      
      private var _txtArr:Array;
      
      public function RookieRankTipItem()
      {
         super();
         _txtArr = [];
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("rookieRank.contentTxt");
            addChild(_loc1_);
            switch(int(_loc2_))
            {
               case 0:
                  _loc1_.width = 20;
                  _loc1_.x = 14;
                  break;
               case 1:
                  _loc1_.width = 110;
                  _loc1_.x = 53;
                  break;
               case 2:
                  _loc1_.width = 100;
                  _loc1_.x = 174;
            }
            _txtArr.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function setData(param1:RookieRankInfo) : void
      {
         _txtArr[0].text = param1.rank;
         _txtArr[1].text = param1.playerName;
         _txtArr[2].text = param1.fightPower;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _txtArr;
         for each(var _loc1_ in _txtArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _txtArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
