<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
  
    
    
    <canvas id="revenueChart" width="400" height="200"></canvas>
    
    <script>
        // Lấy giá trị tổng doanh thu từ request
        var totalRevenue = ${totalRevenue};
        
        // Tạo mảng dữ liệu cho biểu đồ
        var data = {
            labels: ["Tổng Doanh Thu Bán Hàng"],
            datasets: [{
                label: 'Doanh Thu Bán Bàng',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1,
                data: [totalRevenue]
            }]
        };

        // Tạo biểu đồ khi trang được tải
        window.onload = function() {
            var ctx = document.getElementById('revenueChart').getContext('2d');
            var myBarChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        };
    </script>
</body>
</html>
