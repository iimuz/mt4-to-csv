#property strict

#include <stdlib.mqh>

class OrderHistoryItem {
 private:
  int _ticket;
  datetime _openTime;
  double _openPrice;
  int _type;
  double _lots;
  string _symbol;
  double _stopLoss;
  double _takeProfit;
  datetime _closeTime;
  double _closePrice;
  double _commission;
  datetime _expiration;
  double _swap;
  double _profit;
  string _comment;
  int _magicNumber;

 public:
  OrderHistoryItem() {}
  OrderHistoryItem(const int orderIndex) {
    const bool isOrderSelect =
        OrderSelect(orderIndex, SELECT_BY_POS, MODE_HISTORY);
    if (isOrderSelect == false) {
      const int error_code = GetLastError();
      printf("Select order error: error code(%d), detail: %s", error_code,
             ErrorDescription(error_code));
      return;
    }

    _ticket = OrderTicket();
    _openTime = OrderOpenTime();
    _openPrice = OrderOpenPrice();
    _type = OrderType();
    _lots = OrderLots();
    _symbol = OrderSymbol();
    _stopLoss = OrderStopLoss();
    _takeProfit = OrderTakeProfit();
    _closeTime = OrderCloseTime();
    _closePrice = OrderClosePrice();
    _commission = OrderCommission();
    _expiration = OrderExpiration();
    _swap = OrderSwap();
    _profit = OrderProfit();
    _comment = OrderComment();
    _magicNumber = OrderMagicNumber();

    return;
  }

  int ticket() const { return _ticket; }
  datetime openTime() const { return _openTime; }
  double openPrice() const { return _openPrice; }
  int type() const { return _type; }
  double lots() const { return _lots; }
  string symbol() const { return _symbol; }
  double stopLoss() const { return _stopLoss; }
  double takeProfit() const { return _takeProfit; }
  datetime closeTime() const { return _closeTime; }
  double closePrice() const { return _closePrice; }
  double commission() const { return _commission; }
  datetime expiration() const { return _expiration; }
  double swap() const { return _swap; }
  double profit() const { return _profit; }
  string comment() const { return _comment; }
  int magicNumber() const { return _magicNumber; }
};

void OnStart() {
  const int fp =
      FileOpen("OrderHistory.csv", FILE_CSV | FILE_ANSI | FILE_WRITE, ',');
  WriteCSVHeader(fp);

  const int TOTAL_ORDER = OrdersHistoryTotal();
  for (int orderIndex = 0; orderIndex < TOTAL_ORDER; ++orderIndex) {
    const OrderHistoryItem ORDER_ITEM(orderIndex);
    WriteCSVRow(fp, ORDER_ITEM);
  }

  FileClose(fp);
  Alert("Complete!");
}

void WriteCSVHeader(const int fp) {
  FileWrite(fp, "ticket", "openTime", "openPrice", "type", "lots", "symbol",
            "stopLoss", "takeProfit", "closeTime", "closePrice", "commission",
            "expiration", "swap", "profit", "comment", "magicNumber");
}

void WriteCSVRow(const int fp, const OrderHistoryItem& item) {
  FileWrite(fp, item.ticket(), item.openTime(), item.openPrice(), item.type(),
            item.lots(), item.symbol(), item.stopLoss(), item.takeProfit(),
            item.closeTime(), item.closePrice(), item.commission(),
            item.expiration(), item.swap(), item.profit(), item.comment(),
            item.magicNumber());
}
