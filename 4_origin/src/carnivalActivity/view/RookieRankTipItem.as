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
         var i:int = 0;
         var txt:* = null;
         for(i = 0; i < 3; )
         {
            txt = ComponentFactory.Instance.creatComponentByStylename("rookieRank.contentTxt");
            addChild(txt);
            switch(int(i))
            {
               case 0:
                  txt.width = 20;
                  txt.x = 14;
                  break;
               case 1:
                  txt.width = 110;
                  txt.x = 53;
                  break;
               case 2:
                  txt.width = 100;
                  txt.x = 174;
            }
            _txtArr.push(txt);
            i++;
         }
      }
      
      public function setData(info:RookieRankInfo) : void
      {
         _txtArr[0].text = info.rank;
         _txtArr[1].text = info.playerName;
         _txtArr[2].text = info.fightPower;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _txtArr;
         for each(var txt in _txtArr)
         {
            ObjectUtils.disposeObject(txt);
            txt = null;
         }
         _txtArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
