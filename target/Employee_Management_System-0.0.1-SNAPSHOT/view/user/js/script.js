// // ========== Load Shared Components & Default Page ==========
// document.addEventListener("DOMContentLoaded", () => {
//   // Load top navigation
//   fetch("includes/topnav.jsp")
//     .then(res => res.text())
//     .then(html => {
//       document.getElementById("topnav-placeholder").innerHTML = html;
//     })
//     .catch(err => console.error("❌ Failed to load topnav.jsp", err));
//
//   // Load sidebar
//   fetch("includes/sidebar.jsp")
//     .then(res => res.text())
//     .then(html => {
//       document.getElementById("sidebar-placeholder").innerHTML = html;
//     })
//     .catch(err => console.error("❌ Failed to load sidebar.jsp", err));
//
//   // Load default page (Dashboard)
//   loadPage("pages/dashboard.jsp");
// });
//
// // ========== SPA Page Loader ==========
// function loadPage(path) {
//   console.log("📦 Loading page:", path);
//
//   fetch(path)
//     .then(res => {
//       if (!res.ok) throw new Error(`❌ Failed to fetch: ${path} (Status: ${res.status})`);
//       return res.text();
//     })
//     .then(html => {
//       document.getElementById("main-content").innerHTML = html;
//       console.log("✅ Loaded:", path);
//       setupTaskModal(); // if task modal exists on this page
//     })
//     .catch(err => {
//       console.error("⚠️ Error loading page:", err);
//       document.getElementById("main-content").innerHTML =
//         `<div style="color: red; padding: 20px;"><strong>Error loading content:</strong> ${path}</div>`;
//     });
// }
//
// // ========== Sidebar Navigation ==========
// document.addEventListener("click", function (e) {
//   const link = e.target.closest(".user-link");
//   if (link && link.hasAttribute("data-page")) {
//     e.preventDefault();
//     const page = link.getAttribute("data-page");
//     loadPage("pages/" + page);
//   }
// });
//
// // ========== Modal Logic ==========
// function setupTaskModal() {
//   const links = document.querySelectorAll(".task-link");
//   if (!links.length) return;
//
//   links.forEach(link => {
//     link.addEventListener("click", function (e) {
//       e.preventDefault();
//       openTaskDetailModal(
//         this.dataset.title,
//         this.dataset.assignedBy,
//         this.dataset.deadline,
//         this.dataset.file,
//         this.dataset.status,
//         this.dataset.desc
//       );
//     });
//   });
//
//   const modal = document.getElementById("taskDetailModal");
//   const form = document.getElementById("taskSubmitForm");
//
//   if (form) {
//     form.addEventListener("submit", function (e) {
//       e.preventDefault();
//       alert("✅ Task submitted successfully!");
//       closeTaskDetailModal();
//       this.reset();
//     });
//   }
//
//   if (modal) {
//     window.addEventListener("click", function (e) {
//       if (e.target === modal) closeTaskDetailModal();
//     });
//   }
// }
//
// function openTaskDetailModal(title, assignedBy, deadline, file, status, desc) {
//   document.getElementById("taskTitleText").textContent = title;
//   document.getElementById("taskAssignedBy").textContent = assignedBy;
//   document.getElementById("taskDeadline").textContent = deadline;
//   document.getElementById("taskStatus").textContent = status;
//   document.getElementById("taskAdminDesc").textContent = desc;
//
//   const preview = document.getElementById("attachmentPreview");
//   preview.innerHTML = "";
//   const ext = file.split(".").pop().toLowerCase();
//
//   if (["jpg", "jpeg", "png", "gif"].includes(ext)) {
//     preview.innerHTML = `<img src="${file}" alt="Preview" style="width:80px; border-radius:6px;" />`;
//   } else if (ext === "pdf") {
//     preview.innerHTML = `<div class="attachment-icon"><i class="fas fa-file-pdf" style="color:#e74c3c;"></i><span>PDF</span></div>`;
//   } else if (["doc", "docx"].includes(ext)) {
//     preview.innerHTML = `<div class="attachment-icon"><i class="fas fa-file-word" style="color:#2b579a;"></i><span>Word</span></div>`;
//   } else {
//     preview.innerHTML = `<a href="${file}" target="_blank">Download Attachment</a>`;
//   }
//
//   document.getElementById("taskDetailModal").style.display = "flex";
// }
//
// function closeTaskDetailModal() {
//   document.getElementById("taskDetailModal").style.display = "none";
// }
